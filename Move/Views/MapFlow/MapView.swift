//
//  MapView.swift
//  Move
//
//  Created by Victor Cuc on 20/10/2021.
//

import SwiftUI
import NavigationStack

struct MapView: View {
    
    static let id = String(describing: Self.self)
    
    var body: some View {
        
        VStack {
            Button {
                Session.shared.accessToken = nil
            } label: {
                Text("Log out")
            }
            Text("Map here")
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
