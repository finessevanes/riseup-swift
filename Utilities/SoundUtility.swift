import AVFoundation

var audioPlayer: AVAudioPlayer?

class SoundUtility {
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

}
