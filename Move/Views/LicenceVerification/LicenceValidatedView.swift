//
//  LicenceValidationConfirmation.swift
//  Move
//
//  Created by Victor Cuc on 19/10/2021.
//

import SwiftUI

struct LicenceValidatedView: View {
    let onFinished: () -> Void
    
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            VStack {
                Image("checkmark-circle")
                    .padding(.vertical, 72)
                Text("We’ve successfully validated your driving license")
                    .titleStyle()
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: onFinished) {
                    Text("Find scooters")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(MainButtonStyle())
            }
            .foregroundColor(.white)
            .padding(24)
        }
    }
}

struct LicenceValidationConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        LicenceValidatedView(onFinished: {})
    }
}
