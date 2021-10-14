//
//  NavBar.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import SwiftUI

struct NavBar: View {
    var title: String
    var onBack: () -> Void
    
    var body: some View {
            Text(title)
                .font(.Custom.semibold.with(size: 17))
                .foregroundColor(Constants.Colors.primaryTextColor)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 64)
                .frame(height: 54)
                .overlay(
                    backButton
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .background(DefaultBackgroundView())
    }
    
    var backButton: some View {
        Button {
            onBack()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Constants.Colors.primaryTextColor)
                .frame(width: 24, height: 24)
                .frame(maxHeight: .infinity)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 16))
                .font(.Custom.semibold.with(size: 16))
              
        }

    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(title: "DrivingDrivDngDriving ingDriving Licence", onBack: {})
        NavBar(title: "Driving Licence", onBack: {}).preferredColorScheme(.dark)
    }
}
