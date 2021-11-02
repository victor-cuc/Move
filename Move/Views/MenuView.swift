//
//  MenuView.swift
//  Move
//
//  Created by Victor Cuc on 19/10/2021.
//

import SwiftUI

struct MenuView: View {
    
    static let id = String(describing: Self.self)
    
    let indentInsets = EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 0)
    
    var body: some View {
//        Button {
//            Session.shared.accessToken = nil
//        } label: {
//            Text("Log out")
//        }
        VStack (alignment: .leading, spacing: 40) {
            NavBar(title: "Hi *user*", onBack: {})
            rideHistory
                .padding(.horizontal)
                .shadow(radius: 15)
            HStack {
                Image("settings-icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("General Settings")
                    .font(.Custom.bold.with(size: 16))
            }
            Text("Account")
                .font(.Custom.medium.with(size: 14))
                .padding(indentInsets)
            Text("Change password")
                .font(.Custom.medium.with(size: 14))
                .padding(indentInsets)
            
            HStack {
                Image("flag-icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Legal")
                    .font(.Custom.bold.with(size: 16))
            }
            Text("Terms and Conditions")
                .font(.Custom.medium.with(size: 14))
                .padding(indentInsets)
            Text("Privacy Policy")
                .font(.Custom.medium.with(size: 14))
                .padding(indentInsets)
            
            HStack {
                Image("star-icon")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Rate Us")
                    .font(.Custom.bold.with(size: 16))
            }
            Spacer()
        }
        .background(DefaultBackgroundView())
    }
    
    var rideHistory: some View {
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    Text("History")
                        .font(.Custom.bold.with(size: 16))
                    Text("Total rides: N/A")
                        .descriptionStyle()
                        .foregroundColor(Constants.Colors.secondaryTextColor)
                }
                Spacer()
                Button {
                    
                } label: {
                    HStack {
                        Text("See all")
                        Image(systemName: "chevron.forward")
                    }
                }
            .buttonStyle(MainButtonStyle())
            }
            .padding(32)
            .foregroundColor(.white)
            .background(
                ZStack (alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Constants.Colors.backgroundPurple)
                    BackgroundRoundedRectangle()
                        .frame(width: 160, height: 160)
                        .rotationEffect(.degrees(45))
                        .offset(x: 7, y: -20)
                }
            )
            .clipped()
            .cornerRadius(29)
        }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
        MenuView()
            .preferredColorScheme(.dark)
    }
}
