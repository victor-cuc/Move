//
//  MapPin.swift
//  Move
//
//  Created by Victor Cuc on 27/10/2021.
//

import SwiftUI

struct MapPin: View {
    
    let number: Int
    var isSelected = false
    
    var body: some View {
        ZStack {
            Image(isSelected ? "map-pin-selected" : "map-pin")
                .resizable()
                .frame(width: 22.4, height: 28)
        }
    }
}

struct MapPin_Previews: PreviewProvider {
    static var previews: some View {
        MapPin(number: 3)
    }
}
