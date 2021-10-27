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
            showErrorMessage(message: apiError.message)
        default:
            print(error.localizedDescription)
            showErrorMessage(message: error.localizedDescription)
        }
    }
    
    static func showErrorMessage(message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)

        // Theme message elements with the warning style.
        view.configureTheme(.error)

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        view.configureContent(title: "Error", body: message)
        view.button?.isHidden = true
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

        // Show the message.
        SwiftMessages.show(view: view)
    }
}
