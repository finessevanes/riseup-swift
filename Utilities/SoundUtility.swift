import AVFoundation

var audioPlayer: AVAudioPlayer?

class SoundUtility {
    static func playSound(soundName: String) {
        if let path = Bundle.main.path(forResource: soundName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            print(url)
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Couldn't load file \(error)")
            }
        }
    }
    
    static func stopSound() {
        audioPlayer?.stop()
    }

}
