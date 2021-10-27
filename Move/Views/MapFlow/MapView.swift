//
//  MapView.swift
//  Move
//
//  Created by Victor Cuc on 20/10/2021.
//

import SwiftUI
import NavigationStack
import MapKit

struct MapView: View {
    
    static let id = String(describing: Self.self)
    
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
//        VStack {
//            Button {
//                Session.shared.accessToken = nil
//            } label: {
//                Text("Log out")
//            }
//            Text("Map here")
//
//        }
        
        ZStack {
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $viewModel.userTrackingMode
            )
                .ignoresSafeArea()
                
            VStack {
                ForEach(viewModel.scooters, id: \.id) { scooter in
                    Text(scooter.code)
                }
            }
        }

    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel(locationViewModel: LocationViewModel()))
    }
}
