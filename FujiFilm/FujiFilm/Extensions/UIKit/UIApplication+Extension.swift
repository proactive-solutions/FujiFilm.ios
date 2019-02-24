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
                    .badge, .alert, .sound, .provisional, .providesAppNotificationSettings, .criticalAlert,
                ]
            ) { _, _ in }
            registerForRemoteNotifications()
        }

        if #available(iOS 10, *) { // iOS 10 support
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.badge, .alert, .sound]
            ) { _, _ in }
            registerForRemoteNotifications()
        } else if #available(iOS 9, *) { // iOS 9 support
            UIApplication.shared.registerUserNotificationSettings(
                UIUserNotificationSettings(types: [.badge, .sound, .alert],
                                           categories: nil)
            )
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}
