//
//  MapPin.swift
//  Move
//
//  Created by Victor Cuc on 27/10/2021.
//

import SwiftUI

struct MapPin: View {
    var isSelected = false
    let action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            Image(isSelected ? "map-pin-selected" : "map-pin")
                .resizable()
                .frame(width: 22.4, height: 28)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MapPin_Previews: PreviewProvider {
    static var previews: some View {
        MapPin(action: {})
    }
}
