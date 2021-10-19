//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import SwiftUI
import Alamofire

extension NavigationLink where Label == EmptyView {

    init(isActive: Binding<Bool>, @ViewBuilder destination: () -> Destination) {
        self.init(isActive: isActive, destination: destination) {
            EmptyView()
        }
    }
}

extension AuthCoordinatorView {
    
    class ViewModel: ObservableObject {
        @Published var showLogin: Bool = false
        @Published var showLicenceScreen: Bool = false
        @Published var showVerifyingLicenceLoader: Bool = false
        @Published var showLicenceValidatedScreen: Bool = false
        @Published var showCamera: Bool = false
        
        @Published var licencePhoto: UIImage?
        var authResult: AuthResult?
        
        func saveSession() {
            guard let authResult = self.authResult else {
                assert(false, "Unexpected state: Auth result not set")
                return
            }
            Session.shared.accessToken = authResult.authToken
        }
    }
}

struct AuthCoordinatorView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    let onFinished: () -> Void
    
//    var body: some View {
//        NavigationView {
//            licenceScreen
//        }.onAppear {
//            Session.shared.accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MTUxOTQ2OGI1Y2RiYjAwMTYyNmVjYmIiLCJpYXQiOjE2MzQ2NDE0MTV9.mihO0xqlTHNq5HVh7l418eZMGt5pfD4rJU0wMMD60Dw"
//        }
//    }
    
    var body: some View {
        NavigationView {
            signUpScreen
        }
    }
    
    var signUpScreen: some View {
        ZStack {
            SignUpView { authResult in
                viewModel.authResult = authResult
                viewModel.showLicenceScreen = true
            } onLogInInstead: {
                viewModel.showLogin = true
            }
            .navigationBarHidden(true)
            NavigationLink(isActive: $viewModel.showLogin) {
                logInScreen
            }
            NavigationLink(isActive: $viewModel.showLicenceScreen) {
                licenceScreen
            }
        }
    }
    
    var licenceScreen: some View {
        ZStack {
            LicencePromptView {
                viewModel.showCamera = true
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $viewModel.showCamera) {
                guard let image = viewModel.licencePhoto else {
                    return
                }
                viewModel.showCamera = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    viewModel.showVerifyingLicenceLoader = true
                }
                APIService.uploadDriversLicence(image: image) { result in
                    switch result {
                    case .failure(let error):
                        ErrorHandler.handle(error: error)
                        viewModel.showVerifyingLicenceLoader = false
                    case .success:
                        debugPrint("Image uploaded successfully")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.showLicenceValidatedScreen = true
                        }
                    }
                }
            } content: {
                ScannerView(image: $viewModel.licencePhoto)
            }
            NavigationLink(isActive: $viewModel.showVerifyingLicenceLoader) {
                VerifyingLoaderView()
                    .navigationBarHidden(true)
            }
            ZStack {
                NavigationLink(isActive: $viewModel.showLicenceValidatedScreen) {
                    LicenceValidatedView {
                        viewModel.saveSession()
                        onFinished()
                    }
                    .navigationBarHidden(true)
                }
            }
        }
    }
    
    var logInScreen: some View {
        ZStack {
            LogInView { authResult in
                viewModel.authResult = authResult
                if authResult.user.driverLicenseKey != nil {
                    onFinished()
                } else {
                    viewModel.showLicenceScreen = true
                }
                
            } onSignUpInstead: {
                viewModel.showLogin = false
            }
        }
        .navigationBarHidden(true)
    }
}

struct OnboardingCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthCoordinatorView {}
    }
}
