import Foundation
import AudioKit
import SoundpipeAudioKit

class DroneContext { // : NoteEventDelegate {
    let engine = AudioEngine()

    func noteOn(note: MIDINoteNumber) {
        // TODO 1. Generate notes
        var notes = [note, note+2, note-5]

        // 2. Generate sound
        osc.newKeyCentre(notes: notes)

        // TODO 3. Apply filter
        // TODO 4. Apply envelope
        env.openGate()
    }
    
    func noteOff() {
        env.closeGate()
    }

    var osc: DroneOscillator
    var env: AmplitudeEnvelope
    // var fader: Fader

    init(polyphony: Int) {
        osc = SmoothSines(poly: polyphony)
        env = AmplitudeEnvelope(osc.outputSignal)
        env.attackDuration = 0.9 as AUValue
        env.releaseDuration = 0.9 as AUValue

        engine.output = env
    }

    func start() {
        osc.start()
        env.start()
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }

    func stop() {
        osc.stop()
        env.stop()
        engine.stop()
    }
}

