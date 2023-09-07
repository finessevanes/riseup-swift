import SwiftUI

struct AlarmSoundListView: View {
    let sounds: [String: String] = ["Turja": "alarm", "David Goggins": "whos-gonna-carry-the-boats"]
    @State private var currentlyPlaying: String? = nil
    @State private var selectedSound: String? = nil

    var body: some View {
        List(sounds.keys.sorted(), id: \.self) { displayName in
            HStack {
                Text(displayName)
                Spacer()
                Button(action: {
                    if let soundName = sounds[displayName] {
                        if currentlyPlaying == soundName {
                            SoundUtility.stopSound()
                            currentlyPlaying = nil
                        } else {
                            SoundUtility.playSound(soundName: soundName)
                            currentlyPlaying = soundName
                        }
                    }
                }) {
                    Image(systemName: (currentlyPlaying == sounds[displayName]) ? "stop.fill" : "play.fill")
                }
                Toggle("", isOn: Binding(
                    get: { selectedSound == sounds[displayName] },
                    set: { newValue in
                        if newValue {
                            selectedSound = sounds[displayName]
                        } else {
                            selectedSound = nil
                        }
                    }
                ))
                .toggleStyle(SwitchToggleStyle(tint: .red))
            }
        }
    }
}

struct AlarmSoundListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSoundListView()
    }
}
