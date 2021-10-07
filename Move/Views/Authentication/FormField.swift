//
//  FormField.swift
//  Move
//
//  Created by Victor Cuc on 07/10/2021.
//

import SwiftUI

struct FormField: View {
    
    let label: String
    @Binding var text: String
    var guidanceText: String?
    var secure = false
    @State private var isEditing = false
    
    var body: some View {
        VStack (alignment: .leading) {

            Text(label)
                .font(.Custom.regular.with(size: 12))
            
            if secure {
                SecureField(label, text: $text, onCommit: { isEditing = false })
                    .onTapGesture {
                        isEditing = true
                    }
                .font(.Custom.medium.with(size: 16))
            } else {
                TextField(label, text: $text) { isEditing in
                    self.isEditing = isEditing
                }
                .font(.Custom.medium.with(size: 16))
            }
            Rectangle()
                .frame(height: isEditing ? 2 : 1)
                .opacity(isEditing ? 1 : Constants.disabledTextOpacity)
            
            if guidanceText != nil, isEditing {
                Text(guidanceText!)
                    .font(.Custom.regular.with(size: 12))
                    .opacity(Constants.disabledTextOpacity)
            }
        }
        .autocapitalization(.none)
    }
}

extension FormField {
    enum Style {
        case light
        case dark
        
        var foregroundColor: Color {
            switch self {
            case .light:
                return Color.white
            case .dark:
                return Constants.Colors.darkColor
            }
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField(label: "Email", text: .constant(""), guidanceText: "Hello add", secure: true).padding()
        FormField(label: "Email", text: .constant("ffffff"), guidanceText: "Hello add", secure: true).preferredColorScheme(.dark).padding()
    }
}
