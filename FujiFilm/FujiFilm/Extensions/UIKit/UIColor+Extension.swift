//  UIColor+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

extension UIColor {
    class var defaultBlue: UIColor {
        let blue = #colorLiteral(red: 0.1176470588, green: 0.4117647059, blue: 0.9647058824, alpha: 1)
        return blue
    }

    class var textGray: UIColor {
        let gray = #colorLiteral(red: 0.3176470588, green: 0.3215686275, blue: 0.3254901961, alpha: 1)
        return gray
    }

    class var bgDarkGray: UIColor {
        let gray = #colorLiteral(red: 0.6784313725, green: 0.7019607843, blue: 0.737254902, alpha: 1)
        return gray
    }

    class var offGray: UIColor {
        let color = UIColor(red: 151.0 / 255.0, green: 151.0 / 255.0, blue: 151.0 / 255.0, alpha: 0.5)
        return color
    }

    class var paleGrey: UIColor {
        return #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9450980392, alpha: 1)
    }

    class var btcBGColor: UIColor {
        return #colorLiteral(red: 0.9960784314, green: 0.9490196078, blue: 0.8980392157, alpha: 1)
    }
}
