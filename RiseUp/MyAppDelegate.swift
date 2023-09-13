import UIKit
import UserNotifications
import BackgroundTasks

class MyAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Register for User Notifications
        UNUserNotificationCenter.current().delegate = self
        
        // Register Background Fetch Task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.finessevanes.riseup.fetch", using: nil) { task in
            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
        }
        
        return true
    }
    
    func handleBackgroundTask(task: BGAppRefreshTask) {
        // Schedule the next background task
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        scheduleBackgroundTask()
        
        // Perform the background fetch (replace this with your own logic)
        if let soundSelected = SoundUtility.getSelectedSound() {
            SoundUtility.playSound(soundName: soundSelected)
        }
        
        task.setTaskCompleted(success: true)
    }
    
    func scheduleBackgroundTask() {
        let fetchTask = BGAppRefreshTaskRequest(identifier: "com.finessevanes.riseup.fetch")
        fetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 60) // Fetch no earlier than 60 seconds from now
        
        do {
            try BGTaskScheduler.shared.submit(fetchTask)
        } catch {
            print("Could not schedule task: \(error)")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let soundSelected = SoundUtility.getSelectedSound() {
            SoundUtility.playSound(soundName: soundSelected)
        }
        
        completionHandler([.banner, .sound])
    }
}
