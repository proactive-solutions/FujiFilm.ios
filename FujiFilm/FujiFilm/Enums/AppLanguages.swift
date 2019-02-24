//  AppLanguages.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import SwiftyJSON

enum AppLanguages: String {
    case en
    case ja
}

extension AppLanguages {
    private var `extension`: String {
        return "json"
    }

    var languageJSON: JSON? {
        guard let langFileURL = self.languageFileURL else { return nil }
        guard let data = try? Data.init(contentsOf: langFileURL) else { return nil }
        let json = try? JSON.init(data: data)
        return json
    }

    var languageFileURL: URL? {
        let path = Bundle.main.url(
            forResource: self.rawValue,
            withExtension: self.`extension`
        )

        return path
    }
}
