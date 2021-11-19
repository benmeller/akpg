import AudioKit
import SoundpipeAudioKit
import DunneAudioKit
import AVFoundation


class ShimmerBuilder {
    var shimmer: Shimmer

    func addPitch() -> ShimmerBuilder {
        let pshift1 = PitchShifter(
            shimmer.signal,
            shift: 12,
            windowSize: 10000,
            crossfade: 10000
        )
        let pshift2 = PitchShifter(
            shimmer.signal,
            shift: 24,
            windowSize: 10000,
            crossfade: 10000
        )
        let pshift = DryWetMixer(pshift1, pshift2, balance: 0.4)

        shimmer.addNode(
            DryWetMixer(shimmer.signal, pshift, balance: 0.6)
        )
        return self
    }

    func addAppleVerb() -> ShimmerBuilder {
        let verb = Reverb(
            shimmer.signal,
            dryWetMix: 1.0
        )
        verb.loadFactoryPreset(AVAudioUnitReverbPreset.cathedral)
        shimmer.addNode(verb)
        return self
    }

    func addZitaVerb() -> ShimmerBuilder {
        let verb = ZitaReverb(
            shimmer.signal,
            midReleaseTime: 10,
            dryWetMix: 1.0
        )
        shimmer.addNode(verb)
        return self
    }
    
    func addCostelloVerb(fb: AUValue = 0.93) -> ShimmerBuilder {
        let fb_checked = max(min(1.00, fb), 0)
        let verb = CostelloReverb(
            shimmer.signal,
            feedback: fb_checked,
            cutoffFrequency: 18000
        )
        shimmer.addNode(verb)
        return self
    }

    func addDelay() -> ShimmerBuilder {
        let dly = StereoDelay(
            shimmer.signal,
            time: 0.2,
            feedback: 0.5,
            dryWetMix: 0.4
        )
        shimmer.addNode(dly)
        return self
    }

    func addEQ() -> ShimmerBuilder {
        let frequencies: [AUValue] = [316, 2000]
        for f in frequencies {
            shimmer.addNode(ParametricEQ(
                shimmer.signal,
                centerFreq: f,
                q: 1.0,
                gain: -12
            ))
        }
        return self
    }

    func addHighPass() -> ShimmerBuilder {
        let highpass = HighPassFilter(
            shimmer.signal,
            cutoffFrequency: 180
        )
        shimmer.addNode(highpass)
        return self 
    }

    func addCompressor() -> ShimmerBuilder {
        let comp = Compressor(
            shimmer.signal,
            threshold: -16,
            headRoom: 3,
            attackTime: 0.020,
            releaseTime: 0.100,
            masterGain: 0
        )
        shimmer.addNode(comp)
        return self
    }

    func getResult() -> Shimmer {
        return shimmer
    }

    init (_ inputSignal: Node) {
        self.shimmer = Shimmer(inputSignal)
    }
}