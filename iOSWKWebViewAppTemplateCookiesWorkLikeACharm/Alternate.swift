//
//  Alternate.swift
//  iOSWKWebViewAppTemplateCookiesWorkLikeACharm
//
//  Created by Mark Jones on 3/12/23.
//

import UIKit
//@main
class AlternateAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

            if let error = error {
                // Handle the error here.
                print(error)
            }

    // Enable or disable features based on the authorization

            if (granted){
                    UIApplication.shared.registerForRemoteNotifications()
            }
        }
        return  true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken
                     deviceToken: Data) {
        // Send token to your server to send notifications
        print(deviceToken)

    }

    func application(_ application: UIApplication,
                        didFailToRegisterForRemoteNotificationsWithError
                        error: Error) {

        // An error occurred
        print(error)
    }
}
