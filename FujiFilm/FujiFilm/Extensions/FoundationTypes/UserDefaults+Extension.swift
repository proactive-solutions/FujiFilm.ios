//  UserDefaults+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import SwiftyJSON
import CryptoSwift

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case currency
        case firebaseToken
        case shouldShowOnboarding
        case appLanguage
        case networkId
    }

    var currency: String {
        get {
            let value = string(forKey: UserDefaultKeys.firebaseToken.rawValue) ?? "USD"
            return value
        }
        set {
            set(newValue, forKey: UserDefaultKeys.currency.rawValue)
            synchronize()
        }
    }

    var firebaseToken: String? {
        get {
            return string(forKey: UserDefaultKeys.firebaseToken.rawValue)
        }

        set {
            set(newValue, forKey: UserDefaultKeys.firebaseToken.rawValue)
            synchronize()
        }
    }

    var hasOnboardingScreenShown: Bool {
        get {
            return bool(forKey: UserDefaultKeys.shouldShowOnboarding.rawValue)
        }

        set {
            set(newValue, forKey: UserDefaultKeys.shouldShowOnboarding.rawValue)
            synchronize()
        }
    }

    var appLanguage: AppLanguages {
        get {
            if let value = string(forKey: UserDefaultKeys.appLanguage.rawValue) {
                if let lang = AppLanguages(rawValue: value) {
                    return lang
                }
            }
            return AppLanguages.en
        }

        set {
            set(newValue.rawValue, forKey: UserDefaultKeys.appLanguage.rawValue)
            synchronize()
        }
    }

    var network: NetworkId {
        get {
            let value = integer(forKey: UserDefaultKeys.networkId.rawValue)
            if let lang = NetworkId(rawValue: value) {
                return lang
            }
            return NetworkId.testNet
        }

        set {
            set(newValue.rawValue, forKey: UserDefaultKeys.networkId.rawValue)
            synchronize()
        }
    }
}
