//
//  ContentView.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel = OnboardingViewModel()
    
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
                Text(viewModel.currentStep.title)
                    .font(Font.Custom.bold.with(size: 32))
                    .bold()
                Spacer()
                Button {
                    viewModel.getStarted()
                } label: {
                    Text("Skip")
                        .font(Font.Custom.semibold.with(size: 14))
                        .foregroundColor(Constants.Colors.secondaryTextColor)
                }
            }
            .padding(.bottom, 12)
            
            Text(viewModel.currentStep.text)
                .font(Font.Custom.medium.with(size: 16))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                StepIndicatorView(numberOfSteps: viewModel.steps.count, currentStepIndex: viewModel.currentStepIndex)
                Spacer()
                Button(action: {
                    viewModel.nextStep()
                }) {
                    ButtonText(text: viewModel.currentStep.buttonLabelText, symbol: "arrow.forward", isDisabled: .constant(false))
                }
            }
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 40, trailing: 24))
        .background(Constants.Colors.backgroundDefaultColor)
        
    }
    
    var imageContainer: some View {
        Color.white.overlay (
            Image(viewModel.currentStep.imageName)
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
