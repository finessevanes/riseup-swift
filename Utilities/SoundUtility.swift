import AVFoundation

class SoundUtility {
    static var audioPlayer: AVAudioPlayer?
    static func playSound(soundName: String) {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
                print("this is playing")
            } catch {
                print("Couldn't load file \(error)")
            }
        }
    }
    
    static func stopSound() {
        print("stopping sound")
        audioPlayer?.stop()
    }
    
    static func saveSelectedSound(soundName: String) {
        UserDefaults.standard.set(soundName, forKey: "selectedSound")
    }
    
    static func getSelectedSound() -> String? {
        return UserDefaults.standard.string(forKey: "selectedSound")
    }
}
