//  UserDefaults+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case userDetails
    }

    var userDetails: UserDetails? {
        get {
            guard let value = self.data(forKey: UserDefaultKeys.userDetails.rawValue),
                let details = try? JSONDecoder().decode(UserDetails.self, from: value) else {
                return nil
            }
            return details
        }
        set {
            if let details = newValue, let data = try? JSONEncoder().encode(details) {
                set(data, forKey: UserDefaultKeys.userDetails.rawValue)
                synchronize()
            } else {
                set(nil, forKey: UserDefaultKeys.userDetails.rawValue)
            }
        }
    }
}
