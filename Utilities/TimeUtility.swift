import Foundation
import UserNotifications

class TimeUtility {
    static func timeUntilAlarm(alarmTimeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        guard let alarmTime = formatter.date(from: alarmTimeString) else {
            return "Invalid alarm time"
        }
        
        let now = Date()
        let calendar = Calendar.current
        
        // Normalize both dates to the same day
        if let alarmTimeToday = calendar.nextDate(after: now, matching: Calendar.current.dateComponents([.hour, .minute], from: alarmTime), matchingPolicy: .nextTime) {
            
            let components = calendar.dateComponents([.second, .minute, .hour], from: now, to: alarmTimeToday)
            
            if let hour = components.hour, let minute = components.minute, let second = components.second {
                let totalSeconds = (hour * 3600) + (minute * 60) + second
                
                if totalSeconds < 60 {
                    return "\(second) seconds"
                } else if totalSeconds < 3600 {
                    return "\(minute) minutes"
                } else if totalSeconds < 86400 {
                    return "\(hour) hours \(minute) minutes"
                }
            }
        }
        
        return "Alarm time has passed"
    }
    
    static func scheduleNotification(at date: Date) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Rise and Shine"
        content.body = "It's time to get after it!"
        
        if let savedSound = UserDefaults.standard.string(forKey: "selectedSound") {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: savedSound + ".mp3"))
        } else {
            content.sound = .default
        }

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
        center.add(request)
    }

    static func convertToAlarmDate(timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        guard let time = formatter.date(from: timeString) else {
            return nil
        }

        let calendar = Calendar.current
        var components = calendar.dateComponents([.hour, .minute], from: time)
        
        // Get current date components
        let now = Date()
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        
        // Merge both to get date and time components for today's potential alarm
        components.year = currentDateComponents.year
        components.month = currentDateComponents.month
        components.day = currentDateComponents.day
        
        var alarmDate = calendar.date(from: components)
        
        // Check if the alarm should be set for today or tomorrow
        if let alarmDateUnwrapped = alarmDate, alarmDateUnwrapped < now {
            components.day! += 1 // Add one day
            alarmDate = calendar.date(from: components)
        }
        
        return alarmDate
    }
}
