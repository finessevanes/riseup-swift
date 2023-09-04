import Foundation

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

}
