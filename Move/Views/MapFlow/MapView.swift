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
            Map(
                coordinateRegion: viewModel.regionBinding,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $viewModel.userTrackingMode,
                annotationItems: viewModel.scooters,
                annotationContent: { scooter in
                    MapAnnotation(coordinate: scooter.location) {
                        MapPin(number: 3)
                    }
                })
                .ignoresSafeArea()
                .onReceive(viewModel.locationViewModel.objectDidChange) { _ in
                    if viewModel.locationViewModel.location != nil {
                        viewModel.setRegionToCurrentLocation()                        
                    }
                }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: MapViewModel(locationViewModel: LocationViewModel()))
    }
}
