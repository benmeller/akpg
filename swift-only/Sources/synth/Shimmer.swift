import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import DunneAudioKit
import AVFoundation
import AVFAudio

class Shimmer : Node {
    var inputSignal: Node
    public var signal: Node
    var mixer = AVAudioMixerNode()
    public var connections: [Node] { [signal] }
    public var avAudioNode: AVAudioNode

    var nodes: [Node] = []

    func addNode(_ node: Node) {
        // Needs the incoming node to have already set the input field
        // i.e. input: shimmer.signal...
        nodes.append(node)
        signal = node
    }

    func start() {
        for n in nodes {
            n.start()
        }
    }
    
    func stop() {
        for n in nodes {
            n.stop()
        }
    }

    init(_ inputSignal: Node) {
        self.inputSignal = inputSignal
        self.signal = inputSignal
        avAudioNode = mixer
    }
}