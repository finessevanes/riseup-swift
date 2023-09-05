import SwiftUI

struct ContentView: View {
    @ObservedObject var sharedTime = SharedTime()
    // new variable to hold the string value once alarm has been set
    @State var alarmMessage: String = ""
    @State var timeLeft: String = ""
    
    var body: some View {
        VStack {
            Text(alarmMessage)
                .font(.headline)

            TimePickerViewAdapter(sharedTime: sharedTime)
            Button("Set Alarm"){
                let currentTime = TimePickerView().getCurrentTime()
                sharedTime.selectedTime = currentTime
                let time = sharedTime.selectedTime
                timeLeft = TimeUtility.timeUntilAlarm(alarmTimeString: time)
                alarmMessage = "Your alarm has been set for \(time)"
            }            .buttonStyle(CustomButtonStyle())

            Text(timeLeft)
        }
        .padding()
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
