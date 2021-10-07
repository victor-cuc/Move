//
//  Backgrounds.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

struct PurpleBackgroundView: View {
    var body: some View {
        Constants.Colors.backgroundPurple.ignoresSafeArea()
    }
}

struct DefaultBackgroundView: View {
    var body: some View {
        Constants.Colors.backgroundDefaultColor.ignoresSafeArea()
    }
}