//  String+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

extension String {
    var localised: String {
        guard let json = AppEnvironment.active.languageJSON else {
            return self
        }
        return json[self].stringValue
    }

    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isValidPassword: Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordPrediction = NSPredicate(format: "SELF MATCHES %@", "(?=.*[a-zA-Z0-9_-])(?=.*[!@#$%^&+=*]).{8,}")
        return passwordPrediction.evaluate(with: self)
    }
}
