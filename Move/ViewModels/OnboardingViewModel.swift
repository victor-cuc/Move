//
//  OnboardingViewModel.swift
//  Move
//
//  Created by Victor Cuc on 06/10/2021.
//

import SwiftUI

struct OnboardingStep: Equatable {
    let title: String
    let text: String
    let buttonLabelText: String
    let imageName: String
}

class OnboardingViewModel: ObservableObject {
    
    
    let steps: [OnboardingStep] = [
        OnboardingStep(title: "Safety", text: "Please wear a helmet and protect yourself while riding.", buttonLabelText: "Next", imageName: "onboarding-safety"),
        OnboardingStep(title: "Scan", text: "Scan the QR code or NFC sticker on top of the scooter to unlock and ride.", buttonLabelText: "Next", imageName: "onboarding-scan"),
        OnboardingStep(title: "Ride", text: "Step on the scooter with one foot and kick off the ground. When the scooter starts to coast, push the right throttle to accelerate.", buttonLabelText: "Next", imageName: "onboarding-ride"),
        OnboardingStep(title: "Parking", text: "If convenient, park at a bike rack. If not, park close to the edge of the sidewalk closest to the street. Do not block sidewalks, doors or ramps.", buttonLabelText: "Next", imageName: "onboarding-parking"),
        OnboardingStep(title: "Rules", text: "You must be 18 years or and older with a valid driving licence to operate a scooter. Please follow all street signs, signals and markings, and obey local traffic laws.", buttonLabelText: "Get Started", imageName: "onboarding-rules")
    ]
    
    @Published var currentStepIndex: Int
    
    var currentStep: OnboardingStep {
        steps[currentStepIndex]
    }
    
    init() {
        currentStepIndex = 0
    }
    
    func nextStep(onFinished: () -> Void) {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex = currentStepIndex + 1
        } else {
            onFinished()
        }
    }
}
