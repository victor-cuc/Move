//
//  Scooter.swift
//  Move
//
//  Created by Victor Cuc on 26/10/2021.
//

import Foundation
import CoreLocation

class Scooter: Decodable, Identifiable {
    
    let id: String
    let isLocked: Bool
    let code: String
    let batteryLevel: Int
    let location: CLLocationCoordinate2D // Maybe change
    let status: String // Maybe make an enum
    var placemark: CLPlacemark?
    var address: String {
        let street = placemark?.thoroughfare ?? "N/A"
        let number = placemark?.subThoroughfare ?? ""
        return "\(street) \(number)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isLocked = "locked"
        case code = "scooterCode"
        case batteryLevel, location, status
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isLocked = try container.decode(Bool.self, forKey: .isLocked)
        self.code = try container.decode(String.self, forKey: .code)
        self.batteryLevel = try container.decode(Int.self, forKey: .batteryLevel)
        self.status = try container.decode(String.self, forKey: .status)
        
        let coordinates = try container.decode([Double].self, forKey: .location)
        if let longitude = coordinates.first, let latitude = coordinates.last {
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            throw APIError(message: "Invalid format for location", code: -1)
        }
    }
    
    // Dummy init
    
    init() {
        id = "1111"
        isLocked = false
        code = "0000"
        batteryLevel = 88
        location = CLLocationCoordinate2D(latitude: 46.753579, longitude: 23.584384)
        status = "available"
    }
    
    func geocode(_ callback: @escaping () -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude), completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            }
            callback()
        })
    }
    
//    var imageBatteryName: String {
//
//    }
}
