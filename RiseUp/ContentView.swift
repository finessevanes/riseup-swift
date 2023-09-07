import SwiftUI

struct ContentView: View {
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    @ObservedObject var sharedTime = SharedTime()
    // new variable to hold the string value once alarm has been set
    @State var alarmMessage: String = ""
    @State var timeLeft: String = ""
    
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
                Button("Play Sound"){
                    print("playSound was called")
                    SoundUtility.playSound(soundName: "alarm")
                }
                    .buttonStyle(CustomButtonStyle())
                Button("Stop Sound"){
                    print("stopSound was called")
                    SoundUtility.stopSound()
                }
                    .buttonStyle(CustomButtonStyle())
                Button("Set Alarm") {
                    let currentTime = TimePickerView().getCurrentTime()
                    sharedTime.selectedTime = currentTime
                    let time = sharedTime.selectedTime
                    timeLeft = TimeUtility.timeUntilAlarm(alarmTimeString: time)
                    alarmMessage = "Your alarm has been set for \(time)"
                }
                    .buttonStyle(CustomButtonStyle())
                Text(timeLeft)
            }
                .onAppear {
                    requestNotificationAuthorization()
                }
            .padding()
        }
    }
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
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
