//
//  LogInView.swift
//  Move
//
//  Created by Victor Cuc on 08/10/2021.
//

import SwiftUI

struct LogInView: View {
    
    static let id = String(describing: Self.self)
    
    @StateObject var viewModel = LogInViewModel()
    
    private enum Field: Int, Hashable {
        case email, password
    }
    
    @FocusState private var focusedField: Field?
    
    var onLogIn: (AuthResult) -> Void
    var onSignUpInstead: () -> Void
    
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            VStack(alignment: .leading, spacing: 32) {
                logo
                titleAndDescription
                form
                forgotPassword
                logInButton
                signUpInstead
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
            FormField(label: "Email", text: $viewModel.email, error: $viewModel.emailError)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
            
            FormField(label: "Password", text: $viewModel.password, error: $viewModel.passwordError, secure: true)
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
        ZStack (alignment: .trailing) {
            Button {
                print("Log in button pressed")
                viewModel.logIn(onLogIn)
            } label: {
                Text("Log in")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MainButtonStyle())
            .disabled(viewModel.email.isEmpty ||  viewModel.password.isEmpty || viewModel.isLoading)
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
    }

    var signUpInstead: some View {
        HStack (spacing: 0) {
            Spacer()
            Text("Don’t have an account? You can ")
                .font(.Custom.regular.with(size: 12))
            Button {
                onSignUpInstead()
            } label: {
                Text("start with one here")
                    .font(.Custom.semibold.with(size: 12))
                    .underline()
            }
            Spacer()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(onLogIn: {_ in }, onSignUpInstead: {})
        LogInView(onLogIn: {_ in }, onSignUpInstead: {}).preferredColorScheme(.dark)
    }
}
