import CoreML
import CoreMotion

class LapDetection: ObservableObject {
    @Published var lapCount: Int = 0
    @Published var isInTurn: Bool = false
    
    private var motionBuffer: [CMDeviceMotion] = []
    private let bufferSize = 60 // 1 second at 60Hz
    
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
        // Implement turn detection algorithm using CoreML
    }
    
    func reset() {
        lapCount = 0
        isInTurn = false
        motionBuffer.removeAll()
    }
}