//
//  ScooterDetailCardView.swift
//  Move
//
//  Created by Victor Cuc on 28/10/2021.
//

import SwiftUI

struct ScooterDetailCardView: View {
    
//    let scooter: Scooter
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .leading) {
                    BackgroundRoundedRectangle()
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(129))
                        .offset(x: -50, y: -50)
                    Image("scooter")
                        .resizable()
                    .scaledToFit()
                    HStack {
                        Spacer()
                        VStack {
                            HStack {
                                Image("battery-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                Text("82%")
                                    .font(.Custom.medium.with(size: 14))
                            }
                            Button {
                            } label: {
                                Image("ring-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }.buttonStyle(SmallButtonStyle())
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
        .padding()
        .foregroundColor(Constants.Colors.primaryTextColor)
        .background(DefaultBackgroundView())
        .clipped()
    }
    
//    var batteryIcon: some View {
//        let batteryLevel = scooter.batteryLevel
//        var batteryLevelString: String
//
//        if batteryLevel >= 90 {
//            batteryLevelString = "100"
//        } else if batteryLevel >= 70 {
//            batteryLevelString = "80"
//        } else if batteryLevel >= 50 {
//            batteryLevelString = "60"
//        } else if batteryLevel >= 30 {
//            batteryLevelString = "40"
//        } else if batteryLevel >= 10 {
//            batteryLevelString = "20"
//        } else {
//            batteryLevelString = "no"
//        }
//
//        return Image("battery-\(batteryLevelString)-icon")
//    }
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
