//
//  ContentView.swift
//  akpg
//
//  Created by Ben Meller on 14/11/21.
//

import SwiftUI
import AudioKit
import SoundpipeAudioKit

class OscillatorObject {
    var engine = AudioEngine()
    var osc = Oscillator()
    
    init() {
        engine.output = osc
    }
    
    func start() {
        osc.frequency = 440.0
        osc.amplitude = 2.0
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
        osc.start()
    }
    
    func stop() {
        osc.stop()
        engine.stop()
    }
    
}

struct ContentView: View {
    var oscObj = OscillatorObject();
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                oscObj.start();
            }
            .onDisappear() {
                oscObj.stop()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
