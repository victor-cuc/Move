//
//  APIService.swift
//  Move
//
//  Created by Victor Cuc on 13/10/2021.
//

import Foundation
import Alamofire

typealias Result<Success> = Swift.Result<Success, Error>

struct APIService {
    
    static let urlRoot = "https://tapp-scooter-api.herokuapp.com"
    
    static func logIn(email: String, password: String, _ callback: @escaping (Result<AuthResult>) -> Void) {
        AF.request("\(urlRoot)/api/login",
                   method: .post,
                   parameters: ["email": email, "password": password],
                   encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                callback(decodeResult(from: response))
            }
    }
    
    static func register(email: String, username: String, password: String, _ callback: @escaping (Result<AuthResult>) -> Void) {
        AF.request("\(urlRoot)/api/register",
                   method: .post,
                   parameters: ["email": email, "username": username, "password": password],
                   encoder: JSONParameterEncoder.default)
            .validate()
            .responseData { response in
                callback(decodeResult(from: response))
            }
    }
    
    static func decodeResult<T: Decodable>(from response: AFDataResponse<Data>) -> Result<T> {
        if let error = response.error {
            if let data = response.data, let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                return .failure(apiError)
            } else {
                return .failure(error)
            }
        } else {
            if let data = response.data, let result = try? JSONDecoder().decode(T.self, from: data) {
                return .success(result)
            } else {
                return .failure(APIError(message: "Data is missing or could not be decoded", code: -1))
            }
        }
    }
}

struct APIError: LocalizedError, Decodable {
    let message: String
    let code: Int
    
    var localizedDescription: String {
        return message
    }
}
