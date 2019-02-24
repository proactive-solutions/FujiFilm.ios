//  HTMLs.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

enum HTMLs: String {
    case termsOfUse = "TermsOfUse"
    case privacyPolicy = "PrivacyPolicy"
}

extension HTMLs {
    private var `extension`: String {
        return "html"
    }

    var resourceURL: URL? {
        let path = Bundle.main.url(
            forResource: rawValue,
            withExtension: `extension`
        )
        return path
    }
}
