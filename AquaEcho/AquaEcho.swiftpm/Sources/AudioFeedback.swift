import AVFoundation
import SwiftUI

class AudioFeedback: ObservableObject {
    private var engine: AVAudioEngine?
    private var player: AVAudioPlayerNode?
    private var leftPanner: AVAudioPanner?
    private var rightPanner: AVAudioPanner?
    
    @Published var isEnabled: Bool = true {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: "audioFeedbackEnabled")
            if isEnabled {
                setupAudioEngine()
            } else {
                engine?.stop()
            }
        }
    }
    
    init() {
        isEnabled = UserDefaults.standard.bool(forKey: "audioFeedbackEnabled")
        setupAudioEngine()
    }
    
    private func setupAudioEngine() {
        guard isEnabled else { return }
        
        engine = AVAudioEngine()
        player = AVAudioPlayerNode()
        
        guard let engine = engine,
              let player = player else { return }
        
        engine.attach(player)
        
        // Configure spatial audio settings
        let mixer = engine.mainMixerNode
        let format = mixer.outputFormat(forBus: 0)
        
        // Create stereo panning capability
        let pannerNode = AVAudioMixerNode()
        engine.attach(pannerNode)
        
        engine.connect(player, to: pannerNode, format: format)
        engine.connect(pannerNode, to: mixer, format: format)
        
        do {
            try engine.start()
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio engine failed to start: \(error.localizedDescription)")
        }
    }
    
    func playDirectionalCue(direction: Float) {
        guard isEnabled, let player = player else { return }
        
        // Create directional audio cue
        let sampleRate = 44100.0
        let duration = 0.2
        let frequency = 440.0 // A4 note
        
        var signal = [Float]()
        let numSamples = Int(duration * sampleRate)
        
        for i in 0..<numSamples {
            let time = Float(i) / Float(sampleRate)
            let value = sin(2.0 * .pi * frequency * Double(time))
            signal.append(Float(value))
        }
        
        // Apply direction-based amplitude modulation
        let pan = min(max(direction, -1), 1)
        let leftGain = cos((pan + 1) * .pi / 4)
        let rightGain = sin((pan + 1) * .pi / 4)
        
        var stereoSignal = [Float]()
        for sample in signal {
            stereoSignal.append(sample * Float(leftGain))  // Left channel
            stereoSignal.append(sample * Float(rightGain)) // Right channel
        }
        
        // Create audio buffer
        let buffer = AVAudioPCMBuffer(pcmFormat: player.outputFormat(forBus: 0),
                                    frameCapacity: AVAudioFrameCount(stereoSignal.count / 2))!
        
        buffer.frameLength = buffer.frameCapacity
        let channels = buffer.floatChannelData!
        
        // Fill the buffer with our stereo signal
        for frame in 0..<Int(buffer.frameCapacity) {
            channels[0][frame] = stereoSignal[frame * 2]     // Left
            channels[1][frame] = stereoSignal[frame * 2 + 1] // Right
        }
        
        player.scheduleBuffer(buffer, at: nil, options: .interrupts, completionHandler: nil)
        player.play()
    }
    
    func playTurnWarning() {
        guard isEnabled, let player = player else { return }
        
        // Create turn warning sound (higher frequency)
        let sampleRate = 44100.0
        let duration = 0.3
        let frequency = 880.0 // A5 note
        
        var signal = [Float]()
        let numSamples = Int(duration * sampleRate)
        
        for i in 0..<numSamples {
            let time = Float(i) / Float(sampleRate)
            let value = sin(2.0 * .pi * frequency * Double(time))
            signal.append(Float(value))
        }
        
        // Create audio buffer
        let buffer = AVAudioPCMBuffer(pcmFormat: player.outputFormat(forBus: 0),
                                    frameCapacity: AVAudioFrameCount(signal.count))!
        
        buffer.frameLength = buffer.frameCapacity
        let channels = buffer.floatChannelData!
        
        // Fill both channels with the same signal for a centered sound
        for frame in 0..<Int(buffer.frameCapacity) {
            channels[0][frame] = signal[frame]
            channels[1][frame] = signal[frame]
        }
        
        player.scheduleBuffer(buffer, at: nil, options: .interrupts, completionHandler: nil)
        player.play()
    }
    
    deinit {
        engine?.stop()
    }
}