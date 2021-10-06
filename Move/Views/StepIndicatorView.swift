//
//  StepIndicatorView.swift
//  Move
//
//  Created by Victor Cuc on 06/10/2021.
//

import SwiftUI

struct StepIndicatorView: View {
    
    let numberOfSteps: Int
    var currentStepIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSteps) { i in
                Capsule()
                    .fill(i == currentStepIndex ? Constants.Colors.primaryTextColor : Constants.Colors.secondaryTextColor)
                    .frame(width: i == currentStepIndex ? 16: 4, height: 4)
                    .animation(.default)
            }
        }
    }
}
