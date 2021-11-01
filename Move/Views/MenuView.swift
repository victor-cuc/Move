//
//  MenuView.swift
//  Move
//
//  Created by Victor Cuc on 19/10/2021.
//

import SwiftUI

struct MenuView: View {
    
    static let id = String(describing: Self.self)
    
    var body: some View {
//        Button {
//            Session.shared.accessToken = nil
//        } label: {
//            Text("Log out")
//        }
        VStack (alignment: .leading) {
            NavBar(title: "Hi *user*", onBack: {})
            HStack {
                Image("settings-icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("General Settings")
                    .font(.Custom.bold.with(size: 16))
            }
            Text("Account")
                .font(.Custom.medium.with(size: 14))
            Text("Change password")
                .font(.Custom.medium.with(size: 14))
            
            HStack {
                Image("flag-icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Legal")
                    .font(.Custom.bold.with(size: 16))
            }
            Text("Terms and Conditions")
                .font(.Custom.medium.with(size: 14))
            Text("Privacy Policy")
                .font(.Custom.medium.with(size: 14))
            
            HStack {
                Image("star-icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Rate Us")
                    .font(.Custom.bold.with(size: 16))
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
