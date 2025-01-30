import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    
    @Published var headingAngle: Double = 0.0
    @Published var lateralDrift: Double = 0.0
    
    init() {
        setupMotionTracking()
    }
    
    private func setupMotionTracking() {
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        motionManager.startDeviceMotionUpdates(to: queue) { [weak self] motion, error in
            guard let motion = motion, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.processMotionData(motion)
            }
        }
    }
    
    private func processMotionData(_ motion: CMDeviceMotion) {
        // Process gyroscope and accelerometer data for lane drift detection
        headingAngle = motion.attitude.yaw
        lateralDrift = motion.userAcceleration.x
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}