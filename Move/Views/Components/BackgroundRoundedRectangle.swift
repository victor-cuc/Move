//
//  FadedRoundedRectangle.swift
//  Move
//
//  Created by Victor Cuc on 29/10/2021.
//

import SwiftUI

struct BackgroundRoundedRectangle: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 59.04)
            .foregroundColor(Constants.Colors.lightBlue)
    }
}

struct FadedRoundedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundRoundedRectangle()
        BackgroundRoundedRectangle()
            .preferredColorScheme(.dark)
    }
}
