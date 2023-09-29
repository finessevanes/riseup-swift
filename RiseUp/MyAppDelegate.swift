import UIKit
import UserNotifications
import BackgroundTasks

class MyAppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // formats alarm to 2023-09-29 08:37:00 +0000
    var alarmTime: Date?
    // alarm in string
    var sharedTime = SharedTime()
    
    // on application load
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNotification()
        registerBackgroundTask()
        scheduleAppRefresh()
        
        return true
    }
    
    // asks user permission to receive notificaion requests
    private func setupNotification() {
        UNUserNotificationCenter.current().delegate = self
        alarmTime = TimeUtility.convertToAlarmDate(timeString: sharedTime.selectedTime)
        print("Alarm time set to: \(String(describing: alarmTime))")
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAlarmTime(_:)), name: NSNotification.Name("AlarmTimeUpdated"), object: nil)
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error {
                print("Authorization request error: \(error)")
            } else if granted {
                print("Authorization granted.")
            }
        }
    }
        
    // returns true if registered correctly
    private func registerBackgroundTask() {
        // Scheduling a Task
        // func register(forTaskWithIdentifier: String, using: dispatch_queue_t?, launchHandler: (BGTask) -> Void) -> Bool
        // Register a launch handler for the task with the associated identifier that’s executed on the specified queue.
        let isRegistered = BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.finessevanes.riseup.backgroundFetch", using: nil, launchHandler: { task in
            guard let appRefreshTask = task as? BGAppRefreshTask else {
                return
            }
            // should print when background task is actually triggered and executed by the system (does not work)
            print("Background app refresh task triggered.")
            self.handleAppRefresh(task: appRefreshTask)
        })

        if isRegistered {
            print("Background task registered at global scope.")
        } else {
            print("Failed to register background task at global scope.")
        }
    }
    
// returns true if scheduled correctly
    private func scheduleAppRefresh() {
        // Executing app refresh tasks requires setting the fetch UIBackgroundModes capability
        let request = BGAppRefreshTaskRequest(identifier: "com.finessevanes.riseup.backgroundFetch")
        // using nil for no start delay
        request.earliestBeginDate = nil
        // request.earliestBeginDate = alarmTime
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Successfully scheduled app refresh.")
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }

    // gets called when background fetch is triggered (is not getting called)
    private func handleAppRefresh(task: BGAppRefreshTask) {
        print("Handling app refresh.")
        
        if let soundSelected = SoundUtility.getSelectedSound() {
            print("Playing sound while in bg \(soundSelected)")
            SoundUtility.playSound(soundName: soundSelected)
        }
    }
    
    // gets called when user interacts with notification banner while app in background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification was tapped or an action was taken.")
        completionHandler()
    }

    // gets called when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification arrived while app is in the foreground.")
        
        if let soundSelected = SoundUtility.getSelectedSound() {
            print("Playing sound while app is in foreground \(soundSelected)")
            SoundUtility.playSound(soundName: soundSelected)
        }
        
        completionHandler([])
    }
    
    // when alarm gets updated
    @objc private func updateAlarmTime(_ notification: Notification) {
        print("Received alarm time update notification.")
        if let userInfo = notification.userInfo, let alarmDate = userInfo["AlarmTime"] as? Date {
            self.alarmTime = alarmDate
            print("Updated alarm time to: \(alarmDate)")
        }
    }

}

