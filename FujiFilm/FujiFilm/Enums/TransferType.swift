//  TransferType.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import UIKit.UIColor

enum TransferType {
	case credit
	case debit
}

extension TransferType {
	var color: UIColor {
		return self == .credit ? UIColor.green : UIColor.red
	}
}
