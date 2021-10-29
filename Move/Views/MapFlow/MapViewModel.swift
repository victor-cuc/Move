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
    @Published var scooters: [Scooter] = []
    var region: MKCoordinateRegion!
    var didUpdateRegionToCurrentLocation = false
    var onSelectedScooter: ((Scooter) -> Void)?
    
    var currentLocationCoordinates: CLLocationCoordinate2D {
        locationViewModel.location?.coordinate ?? CLLocationCoordinate2D(latitude: 46.767758, longitude: 23.587569)
    }
    
    init(locationViewModel: LocationViewModel) {
        self.locationViewModel = locationViewModel
        region = MKCoordinateRegion(
            center: currentLocationCoordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
    
    var regionBinding: Binding<MKCoordinateRegion> {
        return .init {
            self.region
        } set: { newValue in
            self.region = newValue
        }
    }
    
    func setRegionToCurrentLocation() {
        if didUpdateRegionToCurrentLocation {
            return
        }
        region = MKCoordinateRegion(
            center: currentLocationCoordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        didUpdateRegionToCurrentLocation = true
    }
}
