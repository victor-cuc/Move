//
//  User.swift
//  Move
//
//  Created by Victor Cuc on 13/10/2021.
//

import Foundation

class User: Codable {
    
    let id: String
    let username: String
    var driverLicenseKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username
        case driverLicenseKey
    }
}
