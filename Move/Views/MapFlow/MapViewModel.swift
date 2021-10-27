//
//  MapViewModel.swift
//  Move
//
//  Created by Victor Cuc on 27/10/2021.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published var locationViewModel: LocationViewModel
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 46.767758, longitude: 23.587569),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var scooters: [Scooter] = []
    
    init(locationViewModel: LocationViewModel) {
        self.locationViewModel = locationViewModel
    }
}
