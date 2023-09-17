import UIKit
import UserNotifications

class MyAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        // Register for notifications

        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error {
                print("Authorization request error: \(error)")
            } else if granted {
                print("Authorization granted.")
            }
        }
        
        return true
    }

    // This function will be called when the notification is tapped or an action is taken
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification was tapped or an action was taken.")
        // Your code to handle the notification tap
        completionHandler()
    }

    // This function will be called when a notification arrives while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification arrived while app is in the foreground.")
        // Your code to handle the notification when the app is in the foreground
        completionHandler([.sound])
    }
    
}

