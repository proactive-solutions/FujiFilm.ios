//  UIApplication+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit
import UserNotifications

extension UIApplication {
    func requestPushNotificationPermission() {
        // iOS 12 support
        if #available(iOS 12, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [
                    .badge,
                    .alert,
                    .sound,
                    .provisional,
                    .providesAppNotificationSettings,
                    .criticalAlert,
                ]
            ) { _, _ in }
            registerForRemoteNotifications()
        }

        if #available(iOS 10, *) { // iOS 10 support
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.badge, .alert, .sound]
            ) { _, _ in }
            registerForRemoteNotifications()
        }
    }

    /// Print all the fonts loaded in console. Useful for the dubugging purpose.
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}
