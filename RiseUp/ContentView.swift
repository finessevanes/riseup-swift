import SwiftUI

struct ContentView: View {
    @ObservedObject var sharedTime = SharedTime()
    // New variables
    @State var alarmMessage: String = ""
    @State var timeLeft: String = ""
    @State var showTurnOffButton: Bool = false
    @State var timer: Timer? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Text(alarmMessage)
                    .font(.headline)
            
                TimePickerViewAdapter(sharedTime: sharedTime)
                
                NavigationLink(destination: AlarmSoundListView()) {
                    Text("Choose Alarm Sound")
                }
                .buttonStyle(CustomButtonStyle())
                
                Button("Set Alarm") {
                    let currentTime = sharedTime.selectedTime
                    alarmMessage = "Your alarm has been set for \(currentTime)"
                    if let alarmDate = TimeUtility.convertToAlarmDate(timeString: currentTime) {
                        TimeUtility.scheduleNotification(at: alarmDate)
                        startCountdown(to: alarmDate)
                    }
                }
                .buttonStyle(CustomButtonStyle())
                
                Text(timeLeft)
                
                if showTurnOffButton {
                    Button("Turn Off Alarm") {
                        // Your turn-off logic here
                        timer?.invalidate()
                        showTurnOffButton = false
                        timeLeft = ""
                    }
                    .buttonStyle(CustomButtonStyle())
                }
            }
            .onAppear {
                requestNotificationAuthorization()
            }
            .padding()
        }
    }
    
    func startCountdown(to date: Date) {
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let now = Date()
            if now >= date {
                // Time's up
                timeLeft = "Time's up!"
                showTurnOffButton = true
                timer?.invalidate()
            } else {
                let components = Calendar.current.dateComponents([.hour, .minute, .second], from: now, to: date)
                timeLeft = String(format: "%02d:%02d:%02d", components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
            }
        }
    }
    
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.delegate = UIApplication.shared.delegate as? UNUserNotificationCenterDelegate // Add this line
        center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
            if let error = error {
                // Handle error here, you might want to print or log it
                print("Authorization request error: \(error)")
                return
            }
            
            if granted {
                // The user granted permission, you can now schedule notifications
                print("Permission granted.")
            } else {
                // The user denied permission, you won't be able to show notifications
                print("Permission denied.")
            }
        }
    }
}

struct TimePickerViewAdapter: UIViewControllerRepresentable {
    // to pass this down
    @ObservedObject var sharedTime: SharedTime
    
    func makeUIViewController(context: Context) -> TimePickerView {
        let controller = TimePickerView()
        controller.sharedTime = sharedTime  // Pass the shared state here
        return controller
    }
    
    func updateUIViewController(_ uiViewController: TimePickerView, context: Context) {
        // Update logic here, if needed
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
