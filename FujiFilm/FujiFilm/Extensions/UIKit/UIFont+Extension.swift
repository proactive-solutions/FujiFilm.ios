//  UIFont+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

extension UIFont {
    class func font(style: CustomFontStyle, size: CGFloat) -> UIFont {
        guard let heeboFont = UIFont(name: style.fontName, size: size) else {
            fatalError("Could not create font")
        }
        return heeboFont
    }
}
