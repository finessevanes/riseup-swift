import Foundation
import Combine

class SharedTime: ObservableObject {
    @Published var selectedTime: String = "No time selected"
}
