//  NSObject+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

extension NSObject {
	class var className: String {
		let name = String(describing: self)
		return name
	}
}
