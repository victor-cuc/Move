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
    
//    var imageBatteryName: String {
//
//    }
}
