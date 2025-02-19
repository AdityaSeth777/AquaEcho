import Foundation
import CloudKit

struct CloudConfig {
    static let containerIdentifier = "iCloud.com.aquaecho.app"
    
    struct Zones {
        static let defaultZone = CKRecordZone.default()
        static let sharedZone = CKRecordZone(zoneName: "SharedZone")
        static let workoutZone = CKRecordZone(zoneName: "WorkoutZone")
    }
    
    struct RecordTypes {
        static let profile = "Profile"
        static let session = "Session"
        static let workout = "Workout"
        static let achievement = "Achievement"
    }
    
    struct Subscriptions {
        static let sessionChanges = "session-changes"
        static let profileUpdates = "profile-updates"
        static let achievementUnlocks = "achievement-unlocks"
    }
    
    struct SyncConfig {
        static let batchSize = 100
        static let retryAttempts = 3
        static let retryDelay: TimeInterval = 5.0
        static let maxConcurrentOperations = 5
    }
    
    struct CacheConfig {
        static let maxSize = 100 * 1024 * 1024 // 100MB
        static let expirationInterval: TimeInterval = 7 * 24 * 60 * 60 // 1 week
        static let cleanupInterval: TimeInterval = 24 * 60 * 60 // 1 day
    }
}
