import Foundation
import AudioKit
import SoundpipeAudioKit
import DunneAudioKit


var drone = DroneContext()
drone.start()
print("Hello, world!")
while true {
    drone.noteOn(note: 64 as MIDINoteNumber)
    usleep(2000000)
    drone.noteOff(note: 64 as MIDINoteNumber)
    usleep(2000000)
}