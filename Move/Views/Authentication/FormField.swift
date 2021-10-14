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
    @Binding var error: String?
    var guidanceText: String?
    var secure = false
    @State private var isEditing = false
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(label)
                .font(.Custom.regular.with(size: 12))
                .opacity(isEditing ? 1 : 0)
                .animation(.default, value: isEditing)
                
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
            
            if error != nil {
                underline
                    .foregroundColor(Constants.Colors.errorColor)
                Text(error!)
                    .font(.Custom.regular.with(size: 12))
                    .foregroundColor(Constants.Colors.errorColor)
            } else {
                underline
                if guidanceText != nil, isEditing {
                    Text(guidanceText!)
                        .font(.Custom.regular.with(size: 12))
                }
            }
        }
        .autocapitalization(.none)
    }
    
    var underline: some View {
        Rectangle()
            .frame(height: isEditing || error != nil ? 2 : 1)
            .opacity(isEditing ? 1 : Constants.disabledTextOpacity)
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField(label: "Email", text: .constant(""), error: .constant(nil), guidanceText: "Hello add", secure: true).padding()
        FormField(label: "Email", text: .constant("ffffff"), error: .constant(nil), guidanceText: "Hello add", secure: true).preferredColorScheme(.dark).padding()
    }
}
