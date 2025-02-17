import CoreMotion
import Combine

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    private let updateInterval: TimeInterval = 1.0 / 60.0 // 60Hz updates
    
    @Published var headingAngle: Double = 0.0
    @Published var lateralDrift: Double = 0.0
    @Published var isCalibrated: Bool = false
    
    private var baselineAttitude: CMAttitude?
    private var calibrationOffset: Double = 0.0
    
    init() {
        setupMotionTracking()
    }
    
    private func setupMotionTracking() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion is not available")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = updateInterval
        queue.qualityOfService = .userInteractive
        
        motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: queue) { [weak self] motion, error in
            guard let motion = motion, error == nil else {
                if let error = error {
                    print("Motion update error: \(error.localizedDescription)")
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.processMotionData(motion)
            }
        }
    }
    
    private func processMotionData(_ motion: CMDeviceMotion) {
        if let baseline = baselineAttitude {
            // Apply calibration
            motion.attitude.multiply(byInverseOf: baseline)
            
            // Calculate heading (yaw) relative to calibrated position
            headingAngle = motion.attitude.yaw
            
            // Calculate lateral drift using gravity and user acceleration
            let gravityX = motion.gravity.x
            let userAccelX = motion.userAcceleration.x
            
            // Combine gravity and user acceleration with a low-pass filter
            lateralDrift = (gravityX * 0.8 + userAccelX * 0.2) - calibrationOffset
            
            // Normalize drift to range -1 to 1
            lateralDrift = max(-1, min(1, lateralDrift))
        }
    }
    
    func calibrate() {
        guard let currentMotion = motionManager.deviceMotion else { return }
        
        // Store the current attitude as baseline
        baselineAttitude = currentMotion.attitude
        
        // Store current lateral position as offset
        calibrationOffset = currentMotion.gravity.x
        
        isCalibrated = true
        
        // Reset measurements
        headingAngle = 0.0
        lateralDrift = 0.0
    }
    
    func resetCalibration() {
        baselineAttitude = nil
        calibrationOffset = 0.0
        isCalibrated = false
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}