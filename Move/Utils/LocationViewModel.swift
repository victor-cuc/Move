//
//  LocationManager.swift
//  Move
//
//  Created by Victor Cuc on 26/10/2021.
//

import Foundation
import CoreLocation
import Combine

class LocationViewModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let objectDidChange = PassthroughSubject<Void, Never>()
    
    private let geocoder = CLGeocoder()
    
    @Published var status: CLAuthorizationStatus? {
        didSet { objectDidChange.send() }
    }
    
    @Published var location: CLLocation? {
        didSet { objectDidChange.send() }
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 20.0
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    @Published var placemark: CLPlacemark? {
        willSet { objectDidChange.send() }
    }
    
    private func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
    }
}
