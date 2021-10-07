//
//  Constants.swift
//  Move
//
//  Created by Victor Cuc on 05/10/2021.
//

import SwiftUI

enum Constants {
    enum Colors {
        public static let backgroundDefaultColor = Color("BackgroundDefaultColor")
        public static let backgroundPurple = Color("BackgroundPurple")
        public static let shadowColor = Color("ShadowColor")
        public static let primaryTextColor = Color("PrimaryTextColor")
        public static let secondaryTextColor = Color("SecondaryTextColor")
    }
    
    public static let disabledTextOpacity = 0.5
}

extension Font {
    enum Custom {
        case regular
        case medium
        case semibold
        case bold
        
        func with(size: CGFloat) -> Font {
            switch self {
            case .regular:
                return Font.custom("BaiJamjuree-Regular", size: size)
            case .medium:
                return Font.custom("BaiJamjuree-Medium", size: size)
            case .semibold:
                return Font.custom("BaiJamjuree-SemiBold", size: size)
            case .bold:
                return Font.custom("BaiJamjuree-Bold", size: size)
            }
        }
    }
}
