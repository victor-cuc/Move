//
//  ButtonView.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

struct ButtonText: View {
    var text: String
    @Binding var isDisabled: Bool
    
    var body: some View {
        if !isDisabled {
            Text(text)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16.0)
                                .fill(Color.accentColor))
                .foregroundColor(.white)
        } else {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16.0)
                                .stroke(Color.accentColor.opacity(0.4), lineWidth: 2.5))
                .foregroundColor(Color("TextColor").opacity(0.6))
        }
    }
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonText(text: "Hello", isDisabled: .constant(false))
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
