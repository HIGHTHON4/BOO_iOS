//
//  Boo_App.swift
//  Boo!
//
//  Created by 원이 on 8/2/25.
//

import SwiftUI

import FirebaseCore
import FirebaseMessaging


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("✅ APNs 등록 성공")
        Messaging.messaging().apnsToken = deviceToken
    }
}


@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .onAppear {
                        NotificationsService.shared.setDelegate()
                        NotificationsService.shared.requestPushPermission()
                    }
            }
        }
    }
}
