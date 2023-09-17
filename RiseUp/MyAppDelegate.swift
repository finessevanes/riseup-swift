import UIKit
import UserNotifications

class MyAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
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

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification was tapped or an action was taken.")
//        SoundUtility.stopSound() // Stop the alarm when tapped
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification arrived while app is in the foreground.")
        
        if let soundSelected = SoundUtility.getSelectedSound() {
            print("the selected sound is:")
            print(soundSelected)
            SoundUtility.playSound(soundName: soundSelected) // Play the selected alarm sound
        }
        
        completionHandler([.sound])
    }
}
