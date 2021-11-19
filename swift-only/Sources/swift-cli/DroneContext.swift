import Foundation
import AudioKit
import SoundpipeAudioKit

class DroneContext {
    let engine = AudioEngine()

    func noteOn(note: MIDINoteNumber) {
        // 1. Generate notes
        var notes = [note, note-5, note+2]

        // 2. Generate sound
        osc.notesOn(notes: notes)

        // TODO 3. Apply filter

        // TODO 4. Apply envelope
        // env.openGate()
    }
    
    func noteOff(note: MIDINoteNumber) {
        // TODO 1. Generate notes
        var notes = [note, note-5, note+2]

        osc.notesOff(notes: notes)
        // env.closeGate()
    }

    var osc: DroneOscillator
    var lpf: LowPassFilter
    // var env: AmplitudeEnvelope

    // TODO: Dronecontext shouldn't init all this.
    // Let osc, lpf, etc. be passed in
    init() {
        // osc = SmoothSines(poly: polyphony)
        // osc = dunneSynth(att: 0.9, rel: 5.0)
        lpf = LowPassFilter(osc.outputSignal)
        // env = AmplitudeEnvelope(lpf)

        // Filter and env params
        lpf.cutoffFrequency = 3000 // Hz
        // env.attackDuration = 1.0 as AUValue
        // env.releaseDuration = 1.0 as AUValue

        engine.output = osc.outputSignal
    }

    func start() {
        osc.start()
        lpf.start()
        // env.start()
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }

    func stop() {
        osc.stop()
        lpf.stop()
        // env.stop()
        engine.stop()
    }
}

