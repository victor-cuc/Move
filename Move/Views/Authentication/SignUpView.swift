//
//  File.swift
//  Move
//
//  Created by Victor Cuc on 07/10/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel = SignUpViewModel()
    
    private enum Field: Int, Hashable {
        case email, username, password
    }
    
    var onSignUp: (AuthResult) -> Void
    var onLogInInstead: () -> Void
    
    @FocusState private var focusedField: Field?
    
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
            FormField(label: "Email", text: $viewModel.email, error: $viewModel.emailError)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .username
                }
            FormField(label: "Username", text: $viewModel.username, error: $viewModel.usernameError)
                .focused($focusedField, equals: .username)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
            FormField(label: "Password", text: $viewModel.password, error: $viewModel.passwordError, guidanceText: "Use a strong password (min. 8 characters and use symbols)", secure: true)
                .focused($focusedField, equals: .password)
                .submitLabel(.done)
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
        ZStack (alignment: .trailing) {
            Button {
                print("Get Started button pressed")
                viewModel.register(onSignUp)
            } label: {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MainButtonStyle())
            .disabled(
                viewModel.email.isEmpty ||
                viewModel.username.isEmpty ||
                viewModel.password.isEmpty ||
                viewModel.isLoading
            )
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
    }
    
    var logInInstead: some View {
        HStack (spacing: 0) {
            Spacer()
            Text("You already have an account? You can ")
                .font(.Custom.regular.with(size: 12))
            Button {
                onLogInInstead()
            } label: {
                Text("log in here")
                    .font(.Custom.semibold.with(size: 12))
                    .underline()
            }
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(onSignUp: {_ in }, onLogInInstead: {})
        SignUpView(onSignUp: {_ in }, onLogInInstead: {}).preferredColorScheme(.dark)
    }
}
