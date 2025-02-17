import Foundation
import CoreMotion
import HealthKit

class SwimSessionManager: ObservableObject {
    @Published var isSessionActive = false
    @Published var sessionDuration: TimeInterval = 0
    @Published var lapCount: Int = 0
    @Published var distance: Double = 0
    
    private var startTime: Date?
    private var timer: Timer?
    private let healthKitManager: HealthKitManager
    private let lapDetection = LapDetection()
    
    init(healthKitManager: HealthKitManager = HealthKitManager()) {
        self.healthKitManager = healthKitManager
        
        // Observe lap completion notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLapCompleted),
            name: Notification.Name("LapCompleted"),
            object: nil
        )
    }
    
    func startSession() {
        isSessionActive = true
        startTime = Date()
        lapCount = 0
        distance = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateSessionDuration()
        }
        
        lapDetection.reset()
    }
    
    func endSession() {
        isSessionActive = false
        timer?.invalidate()
        timer = nil
        
        saveSession()
        
        // Reset values
        sessionDuration = 0
        lapCount = 0
        distance = 0
        startTime = nil
    }
    
    private func updateSessionDuration() {
        guard let start = startTime else { return }
        sessionDuration = Date().timeIntervalSince(start)
    }
    
    @objc private func handleLapCompleted() {
        lapCount += 1
        // Update distance based on pool length
        let poolLength = UserDefaults.standard.integer(forKey: "poolLength")
        distance = Double(lapCount * poolLength)
    }
    
    private func saveSession() {
        guard let startTime = startTime else { return }
        
        healthKitManager.saveSwimSession(
            duration: sessionDuration,
            distance: distance,
            laps: lapCount
        )
    }
    
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
}
