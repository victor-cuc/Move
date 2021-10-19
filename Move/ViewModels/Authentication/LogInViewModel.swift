//
//  LogInViewModel.swift
//  Move
//
//  Created by Victor Cuc on 12/10/2021.
//

import Alamofire
import SwiftUI

class LogInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var emailError: String? = nil
    @Published var password: String = ""
    @Published var passwordError: String? = nil
    @Published var isLoading = false
    
    func logIn(_ onSuccess: @escaping (AuthResult) -> Void) {
        if isValid {
            isLoading = true
            APIService.logIn(email: email, password: password) { result in
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
        
        if password.isEmpty {
            passwordError = "Password is empty"
            return false
        }
        
        emailError = nil
        passwordError = nil
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
//    private func makeRequest() {
//        AF.request("https://tapp-scooter-api.herokuapp.com/api/login",
//                   method: .post,
//                   parameters: ["email": email, "password": password],
//                   encoder: JSONParameterEncoder.default).response { response in
////            debugPrint(response)
//            self.handleResponse(response)
//        }
//
//    }

}
