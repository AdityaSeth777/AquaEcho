import Foundation
import WatchConnectivity

struct WatchConfig {
    // Watch session configuration
    static let sessionConfig = WCSessionConfiguration(
        applicationGroupIdentifier: "group.com.aquaecho.app",
        directory: "WatchSync"
    )
    
    // Data transfer settings
    static let transferConfig = WatchTransferConfiguration(
        complicationEnabled: true,
        backgroundRefreshEnabled: true,
        healthSharingEnabled: true
    )
    
    // Workout session settings
    static let workoutConfig = WatchWorkoutConfiguration(
        locationEnabled: true,
        heartRateEnabled: true,
        motionEnabled: true
    )
    
    // Sync settings
    static let syncConfig = WatchSyncConfiguration(
        syncInterval: 30.0, // seconds
        batchSize: 100,
        retryAttempts: 3
    )
}

struct WCSessionConfiguration {
    let applicationGroupIdentifier: String
    let directory: String
}

struct WatchTransferConfiguration {
    let complicationEnabled: Bool
    let backgroundRefreshEnabled: Bool
    let healthSharingEnabled: Bool
}

struct WatchWorkoutConfiguration {
    let locationEnabled: Bool
    let heartRateEnabled: Bool
    let motionEnabled: Bool
}

struct WatchSyncConfiguration {
    let syncInterval: TimeInterval
    let batchSize: Int
    let retryAttempts: Int
}
