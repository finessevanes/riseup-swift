import UIKit
import UserNotifications

class MyAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("this was called")
        if let savedSound = UserDefaults.standard.string(forKey: "selectedSound") {
            SoundUtility.playSound(soundName: savedSound)
        }
        completionHandler([.banner, .sound])
    }
}
