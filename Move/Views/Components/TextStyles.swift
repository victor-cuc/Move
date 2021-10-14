//
//  TextStyles.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import SwiftUI

extension Text {
    
    func titleStyle() -> some View {
        self.font(Font.Custom.bold.with(size: 32))
            .bold()
    }
    
    func opaqueStyle() -> some View {
        self.font(Font.Custom.semibold.with(size: 14))
            .foregroundColor(Constants.Colors.primaryTextColor)
            .opacity(Constants.disabledTextOpacity)
    }
    
    func descriptionStyle() -> some View {
        self.font(Font.Custom.medium.with(size: 16))
            .lineSpacing(8)
    }
}
