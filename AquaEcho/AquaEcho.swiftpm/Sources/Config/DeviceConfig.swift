import Foundation
import CoreBluetooth
import WatchConnectivity
import AVFoundation

struct DeviceConfig {
    // Bluetooth configuration
    static let bluetoothServices: [CBUUID] = [
        CBUUID(string: "181C"), // User Data Service
        CBUUID(string: "180D"), // Heart Rate Service
        CBUUID(string: "181E")  // Position Service
    ]
    
    // Apple Watch connectivity
    static let watchSessionConfig: WCSessionActivationState = .activated
    static let requiredWatchCapabilities: [String] = [
        "accelerometer",
        "gyroscope",
        "heartRate"
    ]
    
    // AirPods configuration
    static let airPodsConfig: [String: Any] = [
        "spatialAudio": true,
        "headTracking": true,
        "dynamicHeadTracking": true,
        "noiseControl": true
    ]
    
    // Audio session configuration
    static let audioSessionConfig: [String: Any] = [
        "category": AVAudioSession.Category.playAndRecord,
        "mode": AVAudioSession.Mode.default,
        "options": [
            AVAudioSession.CategoryOptions.allowBluetooth,
            AVAudioSession.CategoryOptions.allowBluetoothA2DP,
            AVAudioSession.CategoryOptions.mixWithOthers
        ]
    ]
    
    // Motion and sensor settings
    static let motionConfig: [String: Any] = [
        "updateInterval": 1.0 / 60.0, // 60Hz
        "deviceMotionActive": true,
        "accelerometerActive": true,
        "gyroActive": true,
        "magnetometerActive": true
    ]
    
    // HealthKit configuration
    static let healthKitTypes: Set<HKObjectType> = [
        HKObjectType.workoutType(),
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
        HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount)!,
        HKObjectType.quantityType(forIdentifier: .vo2Max)!
    ]
}
