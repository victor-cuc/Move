//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import SwiftUI

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
        @Published var showCamera: Bool = false
        @Published var licencePhoto: UIImage?
    }
}

struct AuthCoordinatorView: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    let onFinished: () -> Void
    
    var body: some View {
        NavigationView {
            signUpScreen
        }
    }
    
    var signUpScreen: some View {
        ZStack {
            SignUpView {
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
            .sheet(isPresented: $viewModel.showCamera) {
                guard let image = viewModel.licencePhoto else {
                    return
                }
                APIService.uploadDriversLicence(image: image) { result in
                    switch result {
                    case .failure(let error):
                        ErrorHandler.handle(error: error)
                    case .success:
                        debugPrint("Image uploaded successfully")
                    }
                    
                }
            } content: {
                ScannerView(image: $viewModel.licencePhoto)
            }
        }
    }
    
    var logInScreen: some View {
        ZStack {
            LogInView {
                onFinished()
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
