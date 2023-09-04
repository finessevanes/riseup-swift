import UIKit

class TimePickerView: UIViewController {

    let timePicker = UIDatePicker()
    var sharedTime: SharedTime?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure date picker
        timePicker.locale = Locale(identifier: "en_GB")
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        

        // Add date picker to the view
        self.view.addSubview(timePicker)

        // Register for date picker changes
        timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
    }

    @objc func timeChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: sender.date)
        
        sharedTime?.selectedTime = "\(timeString)"
    }
    
}
    

