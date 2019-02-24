//  Enums.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

enum CustomFontStyle {
    case black
    case bold
    case extrabold
    case light
    case medium
    case regular
    case thin

    var fontName: String {
        switch self {
        case .black:
            return "Heebo-Black"

        case .bold:
            return "Heebo-Bold"

        case .extrabold:
            return "Heebo-ExtraBold"

        case .light:
            return "Heebo-Light"

        case .medium:
            return "Heebo-Medium"

        case .regular:
            return "Heebo-Regular"

        case .thin:
            return "Heebo-Thin"
        }
    }
}
