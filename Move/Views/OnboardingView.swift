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
        NavigationView {
            ZStack {
                NavigationLink(
                    isActive: $viewModel.moveToNextScreen,
                    destination: {
                        SignUpView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    },
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
                DefaultBackgroundView()
                VStack (spacing: 16) {
                    imageContainer
                    detailContainer
                        .frame(minHeight: 320)
                }
                .foregroundColor(Constants.Colors.primaryTextColor)
            }
            .navigationBarHidden(true)
        }
    }
    
    var detailContainer: some View {
        VStack {
            HStack {
                Text(viewModel.currentStep.title)
                    .titleStyle()
                Spacer()
                Button {
                    viewModel.getStarted()
                } label: {
                    Text("Skip")
                        .opaqueStyle()
                }
            }
            .padding(.bottom, 12)
            
            Text(viewModel.currentStep.text)
                .descriptionStyle()
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                StepIndicatorView(numberOfSteps: viewModel.steps.count, currentStepIndex: viewModel.currentStepIndex)
                Spacer()
                Button(action: {
                    viewModel.nextStep()
                }) {
                    HStack {
                        Text(viewModel.currentStep.buttonLabelText)
                        Image(systemName: "arrow.forward")
                    }
                }
                .buttonStyle(MainButtonStyle())
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
