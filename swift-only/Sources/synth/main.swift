import Foundation 
import AudioKit 
import SoundpipeAudioKit

var synth = Synth(polyphony: 6, releaseTime: 3.5)
synth.start()

var note: MIDINoteNumber = 60

for i in 0..<8 {
    if i % 2 == 0 {
        print("Go high")
        synth.noteOn(note: note+7)
        synth.noteOff(note: note)
    } else {
        print("Go low")
        synth.noteOn(note: note)
        synth.noteOff(note: note+7)
    }
    usleep(1000000)
}

usleep(5000000)

synth.stop()
