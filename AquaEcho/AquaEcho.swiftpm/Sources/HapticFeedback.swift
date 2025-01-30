import CoreHaptics
import UIKit

class HapticFeedback: ObservableObject {
    private var engine: CHHapticEngine?
    
    @Published var isEnabled: Bool = true {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: "hapticFeedbackEnabled")
            if isEnabled {
                setupHapticEngine()
            } else {
                engine?.stop()
            }
        }
    }
    
    init() {
        isEnabled = UserDefaults.standard.bool(forKey: "hapticFeedbackEnabled")
        setupHapticEngine()
    }
    
    private func setupHapticEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
            // Restart the engine in case of failure
            engine?.resetHandler = { [weak self] in
                print("Restarting Haptic engine...")
                do {
                    try self?.engine?.start()
                } catch {
                    print("Failed to restart engine: \(error.localizedDescription)")
                }
            }
            
            engine?.stoppedHandler = { reason in
                print("Haptic engine stopped: \(reason)")
            }
            
        } catch {
            print("Haptic engine failed to start: \(error.localizedDescription)")
        }
    }
    
    func sendTurnAlert() {
        guard isEnabled else { return }
        playHapticPattern(.turnWarning)
    }
    
    func sendDriftWarning(intensity: Float) {
        guard isEnabled else { return }
        playHapticPattern(.driftWarning(intensity: intensity))
    }
    
    private func playHapticPattern(_ pattern: HapticPattern) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine = engine else { return }
        
        do {
            let events = createEvents(for: pattern)
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
    
    private func createEvents(for pattern: HapticPattern) -> [CHHapticEvent] {
        switch pattern {
        case .turnWarning:
            // Create a sharp, attention-grabbing pattern for turns
            return [
                CHHapticEvent(eventType: .hapticTransient, parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
                ], relativeTime: 0),
                CHHapticEvent(eventType: .hapticTransient, parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
                ], relativeTime: 0.1),
                CHHapticEvent(eventType: .hapticTransient, parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
                ], relativeTime: 0.2)
            ]
            
        case .driftWarning(let intensity):
            // Create a continuous pattern that increases with drift intensity
            return [
                CHHapticEvent(eventType: .hapticContinuous, parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: intensity * 0.5)
                ], relativeTime: 0, duration: 0.5)
            ]
        }
    }
    
    enum HapticPattern {
        case turnWarning
        case driftWarning(intensity: Float)
    }
}