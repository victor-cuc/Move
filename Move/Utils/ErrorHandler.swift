//
//  ErrorHandler.swift
//  Move
//
//  Created by Victor Cuc on 13/10/2021.
//

import SwiftUI
import SwiftMessages

class ErrorHandler {
    static func handle(error: Error) {
        switch error {
        case let apiError as APIError:
            print(apiError.message)
        default:
            print(error.localizedDescription)
        }
    }
}
