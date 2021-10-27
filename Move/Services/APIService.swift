//
//  APIService.swift
//  Move
//
//  Created by Victor Cuc on 13/10/2021.
//

import Foundation
import Alamofire
import SwiftUI
import UIKit
import CoreLocation

typealias Result<Success> = Swift.Result<Success, Error>

struct APIService {
    
    static let urlRoot = "https://tapp-scooter-api.herokuapp.com"
    
    static var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        if let token = Session.shared.accessToken {
            headers.add(.authorization(bearerToken: token))
        }
        return headers
    }
    
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
    
    static func uploadDriversLicence(image: UIImage, token: String, _ callback: @escaping (Result<Void>) -> Void) {
        var headers = Self.headers
        headers.add(HTTPHeader.authorization(bearerToken: token))
        let scaledImage = image.scalePreservingAspectRatio(maxEdgeSize: 1200)
        debugPrint("Scaled image size = width: \(scaledImage.size.width), height: \(scaledImage.size.height)")
        
        if let imageData = scaledImage.jpegData(compressionQuality: 0.85) {
            
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                },
                to: "\(urlRoot)/api/uploads", method: .post, headers: headers
            )
            .response { response in
                debugPrint(response)
                callback(decodeVoidResult(from: response))
            }
            .uploadProgress { progress in
                print("Upload progress: \(progress.fractionCompleted)")
                if progress.isFinished {
                    print("Upload finished")
                }
            }
        }
    }
    
    static func getScooters(coordinate: CLLocationCoordinate2D, _ callback: @escaping (Result<[Scooter]>) -> Void) {
        AF.request(
            "\(urlRoot)/api/scooters",
            method: .get,
            parameters: [
                "lat": coordinate.latitude,
                "lon": coordinate.longitude
            ],
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseData { response in
            callback(decodeResult(from: response))
        }
    }
    
    static func decodeVoidResult(from response: AFDataResponse<Data?>) -> Result<Void> {
        if let error = response.error {
            if let data = response.data, let apiError = try? JSONDecoder().decode(APIError.self, from: data) {
                return .failure(apiError)
            } else {
                return .failure(error)
            }
        } else {
            return .success(())
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
    var code: Int? 
    
    var localizedDescription: String {
        return message
    }
}
