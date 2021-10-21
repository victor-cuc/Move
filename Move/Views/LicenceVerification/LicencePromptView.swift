//
//  BeforeStartView.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import SwiftUI

struct LicencePromptView: View {
    
    static let id = String(describing: Self.self)
    
    var onNext: () -> Void
    
    var body: some View {
        ZStack {
            DefaultBackgroundView()
            VStack {
                NavBar(title: "Driving Licence")
                imageContainer
                VStack {
                    textContainer
                    button
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    var imageContainer: some View {
        Color.white.overlay(
            Image("scan-id")
                .resizable()
                .scaledToFill()
        )
    }
    
    var textContainer: some View {
        VStack (alignment: .leading) {
            Text("Before you can start riding")
                .titleStyle()
                .padding(.bottom, 16)
            Text("Please take a photo of your driving licence so we can make sure that it is valid.")
                .descriptionStyle()
        }
        .padding(.bottom, 24)
//        .frame(height: 160)
        .foregroundColor(Constants.Colors.primaryTextColor)
    }
    
    var button: some View {
        Button {
            onNext()
        } label: {
            Text("Add driving licence")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(MainButtonStyle())
    }
}

struct BeforeStartView_Previews: PreviewProvider {
    static var previews: some View {
        LicencePromptView(onNext: {})
        LicencePromptView(onNext: {}).preferredColorScheme(.dark)
    }
}
