import Foundation 
import AudioKit 
import SoundpipeAudioKit

var mytime: useconds_t = 10 * 1000000

var synth = Synth(polyphony: 8, attackTime: 1.0, releaseTime: 1.5, cutoff: 500, shimmerBalance: 0.75)
synth.start()

var note: MIDINoteNumber = 60

for i in 0..<10 {
    if i % 2 == 0 {
        synth.noteOn(note: note)
        synth.noteOff(note: note-5)
    } else {
        synth.noteOn(note: note-5)
        synth.noteOff(note: note)
    }

    if i%5 == 0 {
        synth.noteOn(note: note+2)
    }

    if i < 5 {
        synth.cutoff(synth.lpf.cutoffFrequency + 100)
    } else {
        synth.cutoff(synth.lpf.cutoffFrequency - 100)
    }

    usleep(1000000)
}
synth.allNotesOff()
usleep(5000000)

synth.noteOn(note: note)
synth.noteOn(note: note-5)
synth.noteOn(note: note+2)
synth.noteOn(note: note-12)
synth.noteOn(note: note+7)
synth.noteOn(note: note+12)
usleep(mytime)
synth.allNotesOff()

note = note-2
synth.noteOn(note: note)
synth.noteOn(note: note-5)
synth.noteOn(note: note+2)
synth.noteOn(note: note-12)
synth.noteOn(note: note+7)
synth.noteOn(note: note+12)
usleep(mytime)
synth.allNotesOff()

while true {
    synth.noteOn(note: note)
    synth.noteOn(note: note-5)
    synth.noteOn(note: note-8)
    // synth.noteOn(note: note-24)
    usleep(mytime)
    synth.allNotesOff()

    // 4
    synth.noteOn(note: note)
    synth.noteOn(note: note-5)
    synth.noteOn(note: note-7)
    // synth.noteOn(note: note-19)
    usleep(mytime)
    synth.allNotesOff()
    
    // 6
    synth.noteOn(note: note)
    synth.noteOn(note: note-3)
    synth.noteOn(note: note-8)
    // synth.noteOn(note: note-15)
    usleep(mytime)
    synth.allNotesOff()

    // 4
    synth.noteOn(note: note)
    synth.noteOn(note: note-5)
    synth.noteOn(note: note-7)
    // synth.noteOn(note: note-19)
    usleep(mytime)
    synth.allNotesOff()
}