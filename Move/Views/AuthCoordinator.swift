//
//  OnboardingCoordinatorView.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import SwiftUI
import NavigationStack
import Alamofire

extension AuthCoordinator {
    
    class ViewModel: ObservableObject {

        @Published var showCamera: Bool = false
        
        @Published var licencePhoto: UIImage?
        var authResult: AuthResult?
        
        static var shared = ViewModel()
        
        func saveSession() {
            guard let authResult = self.authResult else {
                assert(false, "Unexpected state: Auth result not set")
                return
            }
            Session.shared.accessToken = authResult.authToken
        }

    }
}

struct AuthCoordinator: View {
    
    @StateObject var viewModel: ViewModel = ViewModel()
    @StateObject var navigationViewModel: NavigationStack = NavigationStack()
    
    let onFinished: () -> Void
    
    
    var body: some View {
        NavigationStackView(navigationStack: navigationViewModel) {
            signUpScreen
        }
        .sheet(isPresented: $viewModel.showCamera) {
            guard let image = viewModel.licencePhoto else {
                return
            }
            viewModel.showCamera = false
            handleLicenceLoader()
            APIService.uploadDriversLicence(image: image) { result in
                switch result {
                case .failure(let error):
                    ErrorHandler.handle(error: error)
                    navigationViewModel.pop()
                case .success:
                    debugPrint("Image uploaded successfully")
                    handleVerificationSuccess()
                }
            }
        } content: {
            ScannerView(image: $viewModel.licencePhoto)
        }
    }
    
    func handleLogin() {
        navigationViewModel.push(logInScreen, withId: LogInView.id)
    }
    
    func handleLicence() {
        navigationViewModel.push(licenceScreen, withId: LicencePromptView.id)
    }

    var signUpScreen: some View {
        SignUpView { authResult in
            viewModel.authResult = authResult
            handleLicence()
        } onLogInInstead: {
            handleLogin()
        }
        .navigationBarHidden(true)
    }
    
    var licenceScreen: some View {
        ZStack {
            LicencePromptView {
                viewModel.showCamera = true
                viewModel.objectWillChange.send()
            }
        }
    }
    
    
    func handleLicenceLoader() {
        navigationViewModel.push(VerifyingLoaderView(), withId: VerifyingLoaderView.id)
    }
    
    func handleVerificationSuccess() {
        let view = LicenceValidatedView {
            viewModel.saveSession()
            onFinished()
        }
        navigationViewModel.push(view, withId: LicenceValidatedView.id)
    }

    var logInScreen: some View {
        LogInView { authResult in
            viewModel.authResult = authResult
            if authResult.user.driverLicenseKey != nil {
                viewModel.saveSession()
                onFinished()
            } else {
                handleLicence()
            }
        } onSignUpInstead: {
            navigationViewModel.pop()
        }
    }
}


