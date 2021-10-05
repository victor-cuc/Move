//
//  ContentView.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            DefaultBackgroundView()
            VStack {
                Text("hifh")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().preferredColorScheme(.dark)
    }
}
