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
    case extraLight
    case semiBold

    var familyName: String {
        return "Raleway"
    }

    var fontName: String {
        /*
         [["Raleway-SemiBoldItalic", "Raleway-Italic", "Raleway-LightItalic",
         "Raleway-ExtraLightItalic", "Raleway-ThinItalic", "Raleway-MediumItalic",
         "Raleway-ExtraBoldItalic", "Raleway-Black", "Raleway-Thin",
         "Raleway-BoldItalic", "Raleway-BlackItalic"]
         ]
         */

        switch self {
        case .black:
            return "Raleway-Black"

        case .bold:
            return "Raleway-Bold"

        case .extrabold:
            return "Raleway-ExtraBold"

        case .light:
            return "Raleway-Light"

        case .medium:
            return "Raleway-Medium"

        case .regular:
            return "Raleway-Regular"

        case .thin:
            return "Raleway-Thin"

        case .extraLight:
            return "Raleway-ExtraLight"

        case .semiBold:
            return "Raleway-SemiBold"
        }
    }
}
