/** 
 * We may be able to implement a simple version of polyphony and voice allocation
 * using a simple round robin technique.
 *
 * We may need to store oscillators or at least their note value in some dict
 * 
 * ------ CALLS TO NOTEON() ------
 * e.g. 6 voices
 * 3 calls to the synths noteOn() is made
 * Voices 0, 1, 2 are assigned and triggered (we might use envelope)
 *
 * 4 new calls made to noteOn()
 * Voices 3, 4, 5, 0 are allocated to the new notes.
 *              See voice 0 has been stolen for the new input
 *
 * If a new noteOn(note) matches an old one, we'll retrigger with the new one
 * and call noteOff() on the old one
 * 
 * ------ CALLS TO NOTEOFF() ------
 * When we receive a noteOff(MIDINoteNumber), we look up the oscillator with that
 * note, close off the envelope gate and reassign 
 */

// import Foundation
// import AudioKit 
// import SoundpipeAudioKit

// let engine = AudioEngine()

// // Ensure roundRobin++ is actually (roundRobin++ % numOsc)
// var roundRobin: Int = 0

// var oscillators: [Oscillator] = []
// var envelopes: [AmplitudeEnvelope] = []
// var outputSignal = Mixer()

// func innit(releaseTime: AUValue) {
//     for _ in 0..<numOsc {
//         let newOsc = Oscillator(waveform: Table(.sawtooth))
//         newOsc.frequency = 0
//         oscillators.append(newOsc)
        
//         let newEnv = AmplitudeEnvelope(newOsc)
//         newEnv.releaseDuration = releaseTime
//         envelopes.append(newEnv)

//         outputSignal.addInput(newEnv)
//     }
//     engine.output = outputSignal
// }

// func mstart() {
//     for i in 0..<numOsc {
//         oscillators[i].start()
//         envelopes[i].start()
//     }
//     do {
//         try engine.start()
//     } catch let err {
//         Log(err)
//     }
// }
// func mstop() {
//     for i in 0..<numOsc {
//         oscillators[i].stop()
//         envelopes[i].stop()
//     }
//     engine.stop()
// }

// func noteOn(note: MIDINoteNumber) {
//     oscillators[roundRobin].frequency = note.midiNoteToFrequency()
//     envelopes[roundRobin].openGate()

//     print("Using oscillator \(roundRobin)")

//     roundRobin = (roundRobin + 1) % numOsc
// }

// func noteOff(note: MIDINoteNumber) {
//     let freq = note.midiNoteToFrequency()

//     for i in 0..<numOsc {
//         // Start at oldest assigned oscillator
//         let offset_i: Int = (roundRobin + i) % numOsc

//         // If we find our frequency, starting at oldest assigned,
//         // Tell envelope to release
//         if oscillators[offset_i].frequency == freq {
//             envelopes[offset_i].closeGate()
//         }
//     }
// }
