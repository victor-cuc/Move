//
//  ContentView.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

struct OnboardingView: View {
    @State private var buttonIsDisabled = false
    
    var body: some View {
        ZStack {
            DefaultBackgroundView()
            VStack (spacing: 16) {
                imageContainer
                detailContainer
                    .frame(minHeight: 320)
            }
            .foregroundColor(Constants.Colors.primaryTextColor)
        }
    }
    
    var detailContainer: some View {
        VStack {
            HStack {
                Text("Safety")
                    .font(Font.Custom.bold.with(size: 32))
                    .bold()
                Spacer()
                Text("Skip")
                    .font(Font.Custom.semibold.with(size: 14))
                    .foregroundColor(Constants.Colors.secondaryTextColor)
            }
            .padding(.bottom, 12)
            
            Text("Please wear a helmet and protect yourself while riding")
                .font(Font.Custom.medium.with(size: 16))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Text("— • • • •")
                Spacer()
                Button(action: {}) {
                    ButtonText(text: "Next",symbol: "arrow.forward" ,isDisabled: $buttonIsDisabled)
                }
            }
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 40, trailing: 24))
        .background(Constants.Colors.backgroundDefaultColor)
        
    }
    
    var imageContainer: some View {
        Color.white.overlay (
            Image("onboarding-safety")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
        OnboardingView().preferredColorScheme(.dark)
    }
}
