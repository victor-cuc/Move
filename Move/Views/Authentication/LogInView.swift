//
//  LogInView.swift
//  Move
//
//  Created by Victor Cuc on 08/10/2021.
//

import SwiftUI

struct LogInView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var inputtedEmail = ""
    @State var emailError: String?
    @State var inputtedPassword = ""
    @State var passwordError: String?
    
    private enum Field: Int, Hashable {
        case email, password
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            VStack(alignment: .leading, spacing: 32) {
                logo
                titleAndDescription
                form
                forgotPassword
                logInButton
                logInInstead
                Spacer()
            }
            .foregroundColor(.white)
            .padding(24)
        }
    }
    
    var logo: some View {
        HStack {
            Image("grey-logo")
                .resizable()
                .frame(width: 56, height: 56)
                .rotationEffect(.degrees(-45))
            Spacer()
        }
    }
    
    var titleAndDescription: some View {
        VStack(alignment: .leading) {
            Text("Log In")
                .font(.Custom.bold.with(size: 32))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            Text("Enter your account credentials and start riding away")
                .font(.Custom.medium.with(size: 20))
                .opacity(Constants.disabledTextOpacity)
        }
    }
    
    var form: some View {
        VStack (spacing: 20) {
            FormField(label: "Email", text: $inputtedEmail, error: $emailError)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
            
            FormField(label: "Password", text: $inputtedPassword, error: $passwordError, secure: true)
                .focused($focusedField, equals: .password)
                .submitLabel(.done)
        }
    }
    
    var forgotPassword: some View {
        Button {
            print("forgot password")
        } label: {
            Text("Forgot your password?")
                .font(.Custom.regular.with(size: 12))
                .underline()
        }
    }
    
    var logInButton: some View {
        Button {
            validateForm()
            print("Log in button pressed")
        } label: {
            HStack {
                Text("Log in")
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(MainButtonStyle())
        .disabled(inputtedEmail.isEmpty ||  inputtedPassword.isEmpty)
    }

    var logInInstead: some View {
        HStack (spacing: 0) {
            Spacer()
            Text("Don’t have an account? You can ")
                .font(.Custom.regular.with(size: 12))
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("start with one here")
                    .font(.Custom.semibold.with(size: 12))
                    .underline()
            }
            Spacer()
        }
    }
    
    private func validateForm() {
        emailError = nil
        passwordError = nil

        if inputtedEmail.isEmpty {
            emailError = "Email is empty"
        } else if !self.isValidEmail(inputtedEmail) {
            emailError = "Email is invalid"
        }
        
        if inputtedPassword.isEmpty {
            passwordError = "Password is empty"
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
        LogInView().preferredColorScheme(.dark)
    }
}
