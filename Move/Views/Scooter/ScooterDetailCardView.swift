//
//  ScooterDetailCardView.swift
//  Move
//
//  Created by Victor Cuc on 28/10/2021.
//

import SwiftUI

struct ScooterDetailCardView: View {
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    BackgroundRoundedRectangle()
                        .frame(width: 152, height: 152)
                        .rotationEffect(.degrees(129))
                        .offset(x: -5, y: -55)
                    Image("scooter")
                        .resizable()
                    .scaledToFit()
                }
                VStack (alignment: .trailing) {
                    Text("Scooter")
                        .opaqueStyle()
                    Text("#1893")
                        .font(.Custom.bold.with(size: 20))
                    HStack {
                        Text("82%")
                            .font(.Custom.medium.with(size: 14))
                    }
                    HStack {
                        Button {
                        } label: {
                            Image("ring-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }.buttonStyle(SmallButtonStyle())
                        Spacer()
                        Button {
                        } label: {
                            Image("location-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .offset(x: -1, y: 1)
                        }.buttonStyle(SmallButtonStyle())
                    }
                }
            }
            HStack {
                Image("pin-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("Address here. Needs to be left aligned!")
                    .font(.Custom.medium.with(size: 14))
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .leading)
            }
            Button {
            } label: {
                Text("Unlock")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MainButtonStyle())
        }
        .foregroundColor(Constants.Colors.primaryTextColor)
        .background(DefaultBackgroundView())
        .clipped()
    }
}

struct ScooterDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterDetailCardView()
            .frame(width: 250, height: 315)
        ScooterDetailCardView()
            .frame(width: 250, height: 315)
            .preferredColorScheme(.dark)
    }
}
