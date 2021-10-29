//
//  SmallButtonStyle.swift
//  Move
//
//  Created by Victor Cuc on 28/10/2021.
//

import SwiftUI

struct SmallButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(Font.Custom.bold.with(size: 16))
                .frame(maxHeight: 56)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 36, height: 36)
                        .foregroundColor(Constants.Colors.backgroundDefaultColor)
                        .shadow(color: Constants.Colors.shadowColor, radius: 20, x: 7, y: 7)
                )
                .foregroundColor(configuration.isPressed ? Constants.Colors.accentColor.opacity(0.4) : Constants.Colors.accentColor)
        }
    }
}
