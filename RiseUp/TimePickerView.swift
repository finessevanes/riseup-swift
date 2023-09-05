import UIKit

class TimePickerView: UIViewController {

    let timePicker = UIDatePicker()
    var sharedTime: SharedTime?

    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.translatesAutoresizingMaskIntoConstraints = false



        // Configure date picker
        timePicker.locale = Locale(identifier: "en_GB")
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        

        // Add date picker to the view
        self.view.addSubview(timePicker)
        
        // this activates where it will sit
        // since i only want it to be center leaving it at the top
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//            timePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])


        // Register for date picker changes
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
    }

    @objc func timeChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: sender.date)
        
        sharedTime?.selectedTime = "\(timeString)"
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: timePicker.date)
    }
}
    

