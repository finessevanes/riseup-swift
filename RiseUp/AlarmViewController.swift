import UIKit

class AlarmViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let soundNames = ["Sound1", "Sound2", "Sound3", "Sound4", "Sound5"]
    var selectedSound = "Sound1"
    
    @IBOutlet weak var soundPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundPicker.delegate = self
        soundPicker.dataSource = self
    }

    // UIPickerView Data Source and Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return soundNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return soundNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSound = soundNames[row]
    }
    
    @IBAction func setAlarm(_ sender: Any) {
        // Your alarm setting code goes here.
        // Use 'selectedSound' and 'timePicker.date'
    }
}
