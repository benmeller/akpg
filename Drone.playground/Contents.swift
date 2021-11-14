import Foundation
import AudioKit
import SporthAudioKit
import SoundpipeAudioKit

// Todo: Map key to frequency

class Drone {
    let engine = AudioEngine()
    
    var osc1 = Oscillator()
    var osc2 = Oscillator()
    var mixer = Mixer()
    
    var _freq: AUValue = 440.0
    var frequency: AUValue {
        get {
            return _freq
        }
        set(newFreq) {
            _freq = newFreq
            osc1.frequency = newFreq as AUValue
            osc2.frequency = (newFreq * 3/4) as AUValue
        }
    }
    
    init() {
        frequency = 440.0
        mixer = Mixer(osc1, osc2)
        mixer.volume = 0.7
        engine.output = mixer
    }
    
    func start() {
        // Get key to plain drone in
        // TODO
        
        // Set osc frequencies
        osc1.frequency = frequency as AUValue
        osc2.frequency = (frequency * 3/4) as AUValue  // 4th below osc1
        
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
        osc1.start()
        osc2.start()
    }
    
    func stop() {
        osc1.stop()
        osc2.stop()
        engine.stop()
    }
}

var drone = Drone()
drone.start()
while true {
    usleep(2000000)
    drone.frequency = drone.frequency * 1.12
}
