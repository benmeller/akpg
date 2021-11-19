import AudioKit
import DunneAudioKit

// I thought Dunne's synth would fix the issue of voice stealing/polyphony.
// It doesn't :'(

class dunneSynth : DroneOscillator  {
    // N.b. Synth has concept of MIDI channels. We're just using default channel 0
    var synth: Synth
    var outputSignal = Mixer()

    let VELOCITY: MIDIVelocity = 40
    var soundingNotes: [MIDINoteNumber] = []

    func notesOn(notes: [MIDINoteNumber]) {
        for note in soundingNotes {
            synth.stop(noteNumber: note)
        }

        for note in notes {
            synth.play(noteNumber: note, velocity: VELOCITY)
        }
        soundingNotes = notes
    }

    func notesOff(notes: [MIDINoteNumber]) {
        for note in soundingNotes {
            synth.stop(noteNumber: note)
        }

        for note in notes {
            synth.stop(noteNumber: note)
        }
    }

    init(att: AUValue = 1.0, rel: AUValue = 3.0) {
        synth = Synth(
            attackDuration: att,
            releaseDuration: rel,
            filterReleaseDuration: 10.0
        )
        outputSignal.addInput(synth)
    }

    func start() {
        // Synth() starts automatically
    }

    func stop() {
        // Synth() stops automatically
        // could either stop all notes
        // or just remove from outputSignal
        outputSignal.removeAllInputs()
    }
}