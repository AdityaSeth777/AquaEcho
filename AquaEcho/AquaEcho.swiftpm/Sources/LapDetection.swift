import CoreML
import CoreMotion

class LapDetection: ObservableObject {
    @Published var lapCount: Int = 0
    @Published var isInTurn: Bool = false
    
    private var motionBuffer: [CMDeviceMotion] = []
    private let bufferSize = 60 // 1 second at 60Hz
    private let turnThreshold: Double = 2.0 // rad/s
    private let turnDuration: Double = 0.5 // seconds
    private var potentialTurnStartTime: Date?
    
    func processMotionData(_ motion: CMDeviceMotion) {
        updateMotionBuffer(motion)
        detectTurn()
    }
    
    private func updateMotionBuffer(_ motion: CMDeviceMotion) {
        motionBuffer.append(motion)
        if motionBuffer.count > bufferSize {
            motionBuffer.removeFirst()
        }
    }
    
    private func detectTurn() {
        guard motionBuffer.count >= 2 else { return }
        
        // Calculate rotation rate magnitude
        let rotationRate = motionBuffer.last!.rotationRate
        let magnitude = sqrt(
            pow(rotationRate.x, 2) +
            pow(rotationRate.y, 2) +
            pow(rotationRate.z, 2)
        )
        
        // Detect start of turn
        if magnitude > turnThreshold && !isInTurn {
            isInTurn = true
            potentialTurnStartTime = Date()
        }
        
        // Detect end of turn
        if let turnStart = potentialTurnStartTime,
           isInTurn && magnitude < turnThreshold {
            let turnEndTime = Date()
            let turnDurationActual = turnEndTime.timeIntervalSince(turnStart)
            
            // Validate turn duration
            if turnDurationActual >= turnDuration {
                lapCount += 1
                NotificationCenter.default.post(
                    name: Notification.Name("LapCompleted"),
                    object: nil
                )
            }
            
            isInTurn = false
            potentialTurnStartTime = nil
        }
    }
    
    func reset() {
        lapCount = 0
        isInTurn = false
        motionBuffer.removeAll()
        potentialTurnStartTime = nil
    }
}