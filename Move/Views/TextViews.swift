//
//  ButtonView.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

struct ButtonText: View {
    var text: String
    var symbol: String?
    @Binding var isDisabled: Bool
    
    var body: some View {
        if !isDisabled {
            HStack {
                Text(text)
                    .font(Font.Custom.bold.with(size: 16))
                if let symbolName = symbol, let image = Image(systemName: symbolName) {
                    image.font(Font.Custom.semibold.with(size: 16))
                }
            }
//                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16.0)
                                .fill(Color.accentColor)
                                .shadow(color: Color.accentColor.opacity(0.2), radius: 20, x: 7, y: 7))
                .foregroundColor(.white)
        } else {
            Text(text)
//                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16.0)
                                .stroke(Color.accentColor.opacity(0.5), lineWidth: 2.5))
                .opacity(Constants.disabledTextOpacity)
        }
    }
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonText(text: "Next", symbol: "arrow.forward", isDisabled: .constant(false))
            ButtonText(text: "Hello", isDisabled: .constant(true))
        }
        .padding()
        
        VStack {
            ButtonText(text: "Hello", isDisabled: .constant(false))
            ButtonText(text: "Hello", isDisabled: .constant(true))
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}
