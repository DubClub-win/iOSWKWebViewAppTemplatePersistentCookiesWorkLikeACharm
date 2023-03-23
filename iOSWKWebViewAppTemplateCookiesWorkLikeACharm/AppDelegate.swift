//
//  AppDelegate.swift
//  iOSWKWebViewAppTemplateCookiesWorkLikeACharm
//
//

import UIKit
import UserNotifications

extension Notification.Name {
    static let viewPlay = Notification.Name("viewPlay")
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    // Deal with notifications that are sent while the app is closed
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                didReceive response: UNNotificationResponse,
                withCompletionHandler completionHandler:
                                @escaping () -> Void) {
        
        if let dubclub =  response.notification.request.content.userInfo["dubclub"] as? Dictionary<String, Any> {
            if let type = dubclub["type"] as? String {
                if type == "play-published" {
                    NotificationCenter.default.post(name: .viewPlay, object: "myObject", userInfo: dubclub)
                }
            }
//                if let playUrl = dubclub["play_url"] as? String {
//                    print("Play URL: \(playUrl)")
//                }
//                if let notificationUrl = dubclub["notification_url"] as? String {
//                    print("Notification URL: \(notificationUrl)")
//                }
        }
//        guard let userInfo = response.notification.request.content.userInfo["dubclub"] as! Dictionary<String, Any>
//        else {
//            guard let notification_type = userInfo["type"] as!String
//            if userInfo["type"] == "play-published" {
//
//            }
    }
    // Deal with notifications that are sent while the app is open
    func userNotificationCenter(_ center: UNUserNotificationCenter,
             willPresent notification: UNNotification,
             withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo //as? Dictionary<String, String>
        print(userInfo["dubclub"])
        if let dubclub =  notification.request.content.userInfo["dubclub"] as? Dictionary<String, Any> {
            if let type = dubclub["type"] as? String {
                if type == "play-published" {
                    NotificationCenter.default.post(name: .viewPlay, object: "myObject", userInfo: dubclub)
                }
            }
        }

    }

}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerForPushNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

