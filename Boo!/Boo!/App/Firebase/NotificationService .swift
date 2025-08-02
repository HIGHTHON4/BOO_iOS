import SwiftUI
import FirebaseCore
import FirebaseMessaging

// UNUserNotificationCenterDelegate의 메소드 구현
class NotificationsService: NSObject, UNUserNotificationCenterDelegate {
  static let shared = NotificationsService()
  let gcmMessageIDKey = "gcm.message_id"

    // 1.
  func requestPushPermission() {
    UNUserNotificationCenter.current().delegate = self
    
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
      if granted {
        print("User granted Notification Permissions")
      } else if let error = error {
        print("에러: \(error)")
      }
    }
  
    DispatchQueue.main.async {
      UIApplication.shared.registerForRemoteNotifications()
    }
  }
  
    // 2.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        return [.banner, .list, .sound]
      }
    
    // 3.
  /// 백그라운드에서 받은 Push 데이터 처리
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    print(userInfo)
  }
}

extension NotificationsService: MessagingDelegate {
  // 4.
  func setDelegate() {
    Messaging.messaging().delegate = self
  }
  
    // 5.
  func messaging(_ messaging: Messaging,
                 didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")
    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
  }
}


extension NotificationsService: UIApplicationDelegate {
    // 6.
  /// 앱이 종료되었을 때에 노티를 탭한 경우 여기서 수신
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    print(userInfo)
    return .newData
  }
 
    // 7.
  func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("앱이 APNs에 성공적으로 등록" )
    Messaging.messaging().apnsToken = deviceToken
  }
}
