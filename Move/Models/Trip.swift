//
//  Ride.swift
//  Move
//
//  Created by Victor Cuc on 02/11/2021.
//

import Foundation
import CoreLocation

class Trip: Decodable, Identifiable {
    let travelTime: Int
    let distance: Double
    let price: Double
    let status: String
    let startLocation: CLLocationCoordinate2D
    let endLocation: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case travelTime, startLocation, endLocation, distance, price, status
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.travelTime = try container.decode(Int.self, forKey: .travelTime)
        self.distance = try container.decode(Double.self, forKey: .distance)
        self.price = try container.decode(Double.self, forKey: .price)
        self.status = try container.decode(String.self, forKey: .status)
        
        let startingCoordinates = try container.decode([Double].self, forKey: .startLocation)
        if let longitude = startingCoordinates.first, let latitude = startingCoordinates.last {
            self.startLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            throw APIError(message: "Invalid format for location", code: -1)
        }
        
        let endingCoordinates = try container.decode([Double].self, forKey: .endLocation)
        if let longitude = endingCoordinates.first, let latitude = endingCoordinates.last {
            self.endLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            throw APIError(message: "Invalid format for location", code: -1)
        }
    }
    
    // Dummy init
    init() {
        travelTime = 600
        distance = 1000.0
        price = 5.00
        status = "completed"
        startLocation = CLLocationCoordinate2D(latitude: 23.5838961666667, longitude: 46.7532763333333)
        endLocation = CLLocationCoordinate2D(latitude: 23.5848961666667, longitude: 46.7532763333333)
    }
}
