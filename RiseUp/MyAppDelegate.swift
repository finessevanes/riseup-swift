//import UIKit
//import UserNotifications
//import BackgroundTasks
//
//class MyAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        // your code
//        UNUserNotificationCenter.current().delegate = self
//        print("this is running")
//
//        return true
//    }
//
//    func userNotificationCenter(
//      _ center: UNUserNotificationCenter,
//      willPresent notification: UNNotification,
//      withCompletionHandler completionHandler:
//      @escaping (UNNotificationPresentationOptions) -> Void) {
//          print("before")
//          completionHandler([ .sound, .banner, .badge, .list])
//          print("after")
//    }
//
//}
