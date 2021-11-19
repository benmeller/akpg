import AudioKit
import AudioKitEX
import SoundpipeAudioKit

struct Voice {
    var osc: Oscillator
    var env: AmplitudeEnvelope

    init(attackTime: AUValue = 0.5, releaseTime: AUValue = 0.5) {
        osc = Oscillator(waveform:Table(.sawtooth))
        osc.frequency = 0

        env = AmplitudeEnvelope(osc)
        env.attackDuration = attackTime
        env.releaseDuration = releaseTime 
    }
}

class Synth {
    let engine = AudioEngine()

    // Sounds
    var voices: [Voice] = []
    var oscSignal = Mixer()
    var lpf: LowPassFilter
    var shimmer: Shimmer
    var outputSignal: Node

    // Variables to track polyphony and voice allocation
    var polyphony: Int 
    var _voiceCounter: Int = 0
    var roundRobin: Int {
        get {
            return _voiceCounter
        }
        set {
            _voiceCounter = newValue % polyphony
        }
    }

    // -------------
    func cutoff(_ freq: AUValue) {
        // Depending on the input we might get from a UI,
        // We might also include some normalisation of the 
        // freq value

        // Bound frequency by limits of lpf
        let boundedFreq = min(22050, max(10, freq))
        lpf.cutoffFrequency = boundedFreq
    }

    func noteOn(note: MIDINoteNumber) {
        let v = voices[roundRobin]
        v.osc.frequency = note.midiNoteToFrequency()
        v.env.openGate()

        // print("Using oscillator \(roundRobin)")

        roundRobin+=1
    }

    func noteOff(note: MIDINoteNumber) {
        let freq = note.midiNoteToFrequency()

        for i in 0..<polyphony {
            // Start at oldest assigned oscillator
            let offset_i: Int = (roundRobin + i) % polyphony

            // If we find our frequency, starting at oldest assigned,
            // Tell envelope to release
            let v = voices[offset_i]
            if v.osc.frequency == freq {
                v.env.closeGate()
            }
        }
    }

    func allNotesOff() {
        for v in voices {
            v.env.closeGate()
        }
    }

    func start() {
        for i in 0..<polyphony {
            voices[i].osc.start()
            voices[i].env.start()
        }
        lpf.start()
        shimmer.start()
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }

    func stop() {
        for i in 0..<polyphony {
            voices[i].osc.stop()
            voices[i].env.stop()
        }
        lpf.stop()
        shimmer.stop()
        engine.stop()
    }

    init(
            polyphony: Int = 6, 
            attackTime: AUValue = 0.5, 
            releaseTime: AUValue = 0.5,
            cutoff: AUValue = 2000,
            shimmerBalance: AUValue = 0.5
    ) {
        self.polyphony = polyphony
        for _ in 0..<polyphony {
            let newVoice = Voice(attackTime: attackTime, releaseTime: releaseTime)
            voices.append(newVoice)
            oscSignal.addInput(newVoice.env)
        }
        lpf = LowPassFilter(oscSignal, cutoffFrequency: cutoff)

        // For now, have the effect onboard in the synth
        shimmer = ShimmerBuilder(lpf)
                    .addPitch()
                    .addEQ()
                    .addCostelloVerb(fb: 0.90)      // Opt1. Swelling waves of shimmer
                    .addCompressor()
                    .addDelay()
                    // .addCostelloVerb(fb: 0.6)   // Opt2. Sounds like trilling flutes on chord changes
                    .addCostelloVerb()
                    .addHighPass()
                    .getResult()
        outputSignal = DryWetMixer(lpf, shimmer, balance: shimmerBalance)

        engine.output = outputSignal
    }
}