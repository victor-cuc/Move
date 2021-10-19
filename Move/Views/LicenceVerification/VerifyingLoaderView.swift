//
//  VerifyingLoaderView.swift
//  Move
//
//  Created by Victor Cuc on 19/10/2021.
//

import SwiftUI

struct VerifyingLoaderView: View {
    var body: some View {
        ZStack {
            PurpleBackgroundView()
            VStack {
                Text("We are currently verifying your driving licence")
                    .titleStyle()
                    .multilineTextAlignment(.center)
                ProgressView()
                    .foregroundColor(.white)
                    .padding()
            }
            .foregroundColor(.white)
        }
    }
}

struct VerifyingLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyingLoaderView()
    }
}
