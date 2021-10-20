//
//  MenuView.swift
//  Move
//
//  Created by Victor Cuc on 19/10/2021.
//

import SwiftUI

struct MenuView: View {
    
    static let id = String(describing: Self.self)
    
    var body: some View {
        Button {
            Session.shared.accessToken = nil
        } label: {
            Text("Log out")
        }

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
