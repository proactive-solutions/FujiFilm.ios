//  File.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import UIKit

extension UISegmentedControl {
	func setFont(style: CustomFontStyle, size: CGFloat) {
		let font = UIFont.font(style: style, size: size)
		setTitleTextAttributes(
			[NSAttributedString.Key.font: font],
			for: .normal
		)
	}
}
