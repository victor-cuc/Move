//
//  Session.swift
//  Move
//
//  Created by Victor Cuc on 14/10/2021.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    private let userDefaultsKey = "accessTokenKey"
    
    var isActive: Bool {
        accessToken != nil
    }
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: userDefaultsKey)
        }
        
        set {
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: userDefaultsKey)
            } else {
                UserDefaults.standard.removeObject(forKey: userDefaultsKey)
            }
        }
    }
}
