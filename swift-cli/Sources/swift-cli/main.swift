import Foundation
import AudioKit
import SoundpipeAudioKit

print("Hello, world!")

var drone = DroneContext(polyphony: 3)
drone.start()
while true {
    drone.noteOn(note: 64 as MIDINoteNumber)
    usleep(2000000)
    drone.noteOff()
    usleep(2000000)
}