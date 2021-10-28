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
            Image("map-pin")
                .resizable()
                .frame(width: 22.4, height: 28)
            Text(String(number))
                .font(.Custom.medium.with(size: 12))
                .offset(x: 0, y: -3)
        }
    }
}

struct MapPin_Previews: PreviewProvider {
    static var previews: some View {
        MapPin(number: 3)
    }
}
