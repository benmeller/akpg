import AudioKit

protocol DroneOscillator { // : Node {
    var polyphony: Int { get }
    var outputSignal: Mixer { get }

    func start()
    func stop()
    func newKeyCentre(notes: [MIDINoteNumber])
}