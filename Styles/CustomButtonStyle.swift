import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 203, height: 54)
            .background(Color(red: 185/255, green: 141/255, blue: 46/255))
            .cornerRadius(5)
            .foregroundColor(Color.white)
            .padding(20)
    }
}
