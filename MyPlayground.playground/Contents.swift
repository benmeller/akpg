import Foundation
import AudioKit
import SoundpipeAudioKit

class OscillatorObject {
    var engine = AudioEngine()
    var osc = Oscillator()
    
    init() {
        engine.output = osc
    }
    
    func start() {
        osc.frequency = 440.0
        osc.amplitude = 2.0
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
        osc.start()
    }
    
    func stop() {
        osc.stop()
        engine.stop()
    }
    
}

var oscObj = OscillatorObject()
while true {
    oscObj.start()
    usleep(3000000)
    oscObj.stop()
    usleep(3000000)
}
