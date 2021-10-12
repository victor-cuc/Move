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
    
    func validateForm() {
        emailError = nil
        usernameError = nil
        passwordError = nil

        if email.isEmpty {
            emailError = "Email is empty"
        } else if !isValidEmail(email) {
            emailError = "Email is invalid"
        }
        
        if username.isEmpty {
            usernameError = "Username is empty"
        }
        
        if password.isEmpty {
            passwordError = "Password is empty"
        } else if password.count < 8 {
            passwordError = "Password must contain at least 8 characters"
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
