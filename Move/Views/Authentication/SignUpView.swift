//
//  File.swift
//  Move
//
//  Created by Victor Cuc on 07/10/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @State var inputtedEmail = ""
    @State var emailError: String?
    @State var inputtedPassword = ""
    @State var passwordError: String?
    @State var inputtedUsername = ""
    @State var usernameError: String?
    
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            VStack(alignment: .leading, spacing: 32) {
                logo
                titleAndDescription
                form
                termsAndConditions
                getStartedButton
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
            Text("Let's get started")
                .font(.Custom.bold.with(size: 32))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            Text("Sign up or log in and start riding right away")
                .font(.Custom.medium.with(size: 20))
                .opacity(Constants.disabledTextOpacity)
        }
    }
    
    var form: some View {
        VStack (spacing: 20) {
            FormField(label: "Email", text: $inputtedEmail, error: $emailError)
            FormField(label: "Username", text: $inputtedUsername, error: $usernameError)
            FormField(label: "Password", text: $inputtedPassword, error: $passwordError, guidanceText: "Use a strong password (min. 8 characters and use symbols)", secure: true)
        }
    }
    
    var termsAndConditions: some View {
        VStack (alignment: .leading) {
            Text("By continuing you agree to Move's ")
                .font(.Custom.regular.with(size: 12))
            HStack (spacing: 0) {
                Link(
                    destination: URL(string: "http://tapptitude.com")!,
                    label: {
                        Text("Terms and Conditions ")
                            .font(.Custom.semibold.with(size: 12))
                            .underline()
                    }
                )
                Text(" and ")
                    .font(.Custom.regular.with(size: 12))
                Link(
                    destination: URL(string: "http://tapptitude.com")!,
                    label: {
                        Text("Privacy Policy")
                            .font(.Custom.semibold.with(size: 12))
                            .underline()
                    }
                )
            }
        }
    }
    
    var getStartedButton: some View {
        Button {
            print("Get Started button pressed")
            validateForm()
        } label: {
            HStack {
                Text("Get Started")
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(MainButtonStyle())
        .disabled(inputtedEmail.isEmpty || inputtedUsername.isEmpty || inputtedPassword.isEmpty)
    }
    
    var logInInstead: some View {
        HStack (spacing: 0) {
            Spacer()
            Text("You already have an account? You can ")
                .font(.Custom.regular.with(size: 12))
            NavigationLink {
                LogInView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            } label: {
                Text("log in here")
                    .font(.Custom.semibold.with(size: 12))
                    .underline()
            }
            Spacer()
        }
    }
    
    private func validateForm() {
        emailError = nil
        usernameError = nil
        passwordError = nil

        if inputtedEmail.isEmpty {
            emailError = "Email is empty"
        } else if !self.isValidEmail(inputtedEmail) {
            emailError = "Email is invalid"
        }
        
        if inputtedUsername.isEmpty {
            usernameError = "Username is empty"
        }
        
        if inputtedPassword.isEmpty {
            passwordError = "Password is empty"
        } else if inputtedPassword.count < 8 {
            passwordError = "Password must contain at least 8 characters"
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
        SignUpView().preferredColorScheme(.dark)
    }
}
