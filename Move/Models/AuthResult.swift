//
//  AuthResult.swift
//  Move
//
//  Created by Victor Cuc on 13/10/2021.
//

import Foundation

class AuthResult: Decodable {
    
    let authToken: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case authToken, user, email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authToken = try container.decode(String.self, forKey: .authToken)
        self.user = try container.decode(User.self, forKey: .user)
        
//        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
//        let email = try nestedContainer.decode(String.self, forKey: .email)
    }
}
