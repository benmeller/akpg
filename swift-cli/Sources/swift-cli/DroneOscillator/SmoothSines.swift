import AudioKit
import SoundpipeAudioKit

class SmoothSines: DroneOscillator {
    var outputSignal = Mixer()

    // If DroneOscillator conforms to Node...
    // var connections: [Node] = []
    // var avAudioNode: AVAudioNode

    var oscillators: [Oscillator] = []
    var polyphony: Int

    func start() {
        for osc in oscillators {
            osc.start()
        }
    }

    func stop() {
        for osc in oscillators {
            osc.stop()
        }
    }

    func newKeyCentre(notes: [MIDINoteNumber]) {
        // Start fresh with mixer, so only the relevant oscillators can be heard
        // TODO: If changing key, this will cut the former key short...
        outputSignal.removeAllInputs()

        for (osc, note) in zip(oscillators, notes) {
            osc.frequency = note.midiNoteToFrequency()
            outputSignal.addInput(osc)
        }
    }


    init(poly: Int) {
        polyphony = poly

        var newOsc: Oscillator
        for _ in 0..<polyphony {
            newOsc = Oscillator()
            oscillators.append(newOsc)
        }
    }
}