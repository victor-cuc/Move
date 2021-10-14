//
//  MainButtonStyle.swift
//  Move
//
//  Created by Victor Cuc on 11/10/2021.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(Font.Custom.bold.with(size: 16))
                .padding()
                .frame(maxHeight: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16.0)
                        .fill(
                            Constants.Colors.accentColor
                                .opacity(isEnabled ? 1 : 0))
                        .shadow(color: Color.accentColor.opacity(isEnabled ? 0.2 : 0), radius: 20, x: 7, y: 7)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16.0)
                        .stroke(
                            Constants.Colors.accentColor
                                .opacity(isEnabled ? 0 : Constants.disabledTextOpacity),
                            lineWidth: 2.5
                        )
                )
                .foregroundColor(.white)
        }
    }
}
