import Foundation
import Combine
import CoreBluetooth
import WatchConnectivity
import HealthKit
import AVFAudio

class DeviceSyncManager: NSObject, ObservableObject {
    static let shared = DeviceSyncManager()
    
    @Published private(set) var watchConnected = false
    @Published private(set) var airPodsConnected = false
    @Published private(set) var healthKitAuthorized = false
    @Published private(set) var isSyncing = false
    
    private var watchSession: WCSession?
    private var healthStore: HKHealthStore?
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        setupWatchConnectivity()
        setupHealthKit()
        setupAirPodsMonitoring()
    }
    
    private func setupWatchConnectivity() {
        guard WCSession.isSupported() else { return }
        
        watchSession = WCSession.default
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    private func setupHealthKit() {
        healthStore = HKHealthStore()
        
        guard let healthStore = healthStore else { return }
        
        let types = DeviceConfig.healthKitTypes
        
        healthStore.requestAuthorization(toShare: types, read: types) { [weak self] success, error in
            DispatchQueue.main.async {
                self?.healthKitAuthorized = success
                if let error = error {
                    print("HealthKit authorization failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func setupAirPodsMonitoring() {
        NotificationCenter.default.publisher(for: AVAudioSession.routeChangeNotification)
            .sink { [weak self] notification in
                self?.handleAudioRouteChange(notification)
            }
            .store(in: &cancellables)
    }
    
    private func handleAudioRouteChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }
        
        switch reason {
        case .newDeviceAvailable:
            checkForAirPods()
        case .oldDeviceUnavailable:
            airPodsConnected = false
        default:
            break
        }
    }
    
    private func checkForAirPods() {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        for output in currentRoute.outputs {
            if output.portType == .bluetoothA2DP {
                // Check if the device is AirPods
                if output.portName.contains("AirPods") {
                    airPodsConnected = true
                    configureSpatialAudio()
                    return
                }
            }
        }
        airPodsConnected = false
    }
    
    private func configureSpatialAudio() {
        guard airPodsConnected else { return }
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(
                AirPodsConfig.audioSessionConfig.category,
                mode: AirPodsConfig.audioSessionConfig.mode,
                options: AirPodsConfig.audioSessionConfig.options
            )
            try session.setActive(true)
        } catch {
            print("Failed to configure spatial audio: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Public Methods
    
    func syncWorkoutData(_ workout: HKWorkout) {
        guard healthKitAuthorized else { return }
        
        isSyncing = true
        
        // Sync with HealthKit
        healthStore?.save(workout) { [weak self] success, error in
            if let error = error {
                print("Failed to sync workout: \(error.localizedDescription)")
            }
            
            // Sync with Watch if available
            if self?.watchConnected == true {
                self?.sendWorkoutToWatch(workout)
            }
            
            DispatchQueue.main.async {
                self?.isSyncing = false
            }
        }
    }
    
    private func sendWorkoutToWatch(_ workout: HKWorkout) {
        guard let watchSession = watchSession,
              watchSession.isReachable else { return }
        
        let workoutData: [String: Any] = [
            "type": "workout",
            "startDate": workout.startDate,
            "endDate": workout.endDate,
            "duration": workout.duration,
            "totalDistance": workout.totalDistance?.doubleValue(for: .meter()) ?? 0,
            "totalEnergyBurned": workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0
        ]
        
        watchSession.transferUserInfo(workoutData)
    }
}

// MARK: - WCSessionDelegate
extension DeviceSyncManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.watchConnected = activationState == .activated
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        DispatchQueue.main.async {
            self.watchConnected = false
        }
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Reactivate the session
        WCSession.default.activate()
    }
    
    #if os(iOS)
    func sessionWatchStateDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.watchConnected = session.isReachable
        }
    }
    #endif
}
