//
//  SignUpViewModel.swift
//  Move
//
//  Created by Victor Cuc on 12/10/2021.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var emailError: String? = nil
    @Published var password: String = ""
    @Published var passwordError: String? = nil
    @Published var username: String = ""
    @Published var usernameError: String? = nil
    @Published var isLoading = false
    
    func register(_ onSuccess: @escaping (AuthResult) -> Void) {
        if isValid {
            isLoading = true
            APIService.register(email: email, username: username, password: password) { result in
                switch result {
                case .success(let authResult): 
                    onSuccess(authResult)
                case .failure(let error):
                    ErrorHandler.handle(error: error)
                }
                self.isLoading = false
            }
        }
    }
    
    var isValid: Bool {

        if email.isEmpty {
            emailError = "Email is empty"
            return false
        } else if !isValidEmail(email) {
            emailError = "Email is invalid"
            return false
        }
        
        if username.isEmpty {
            usernameError = "Username is empty"
            return false
        }
        
        if password.isEmpty {
            passwordError = "Password is empty"
            return false
        } else if password.count < 8 {
            passwordError = "Password must be 8 characters or longer"
            return false
        }
        
        emailError = nil
        usernameError = nil
        passwordError = nil
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
