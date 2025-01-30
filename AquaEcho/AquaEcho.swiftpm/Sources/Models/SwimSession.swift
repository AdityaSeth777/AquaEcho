import Foundation
import HealthKit

struct SwimSession: Identifiable, Codable {
    let id: UUID
    let date: Date
    let duration: TimeInterval
    let distance: Double
    let laps: Int
    let strokeStyle: UserProfile.StrokeStyle
    let averagePace: TimeInterval
    var laneDeviations: [LaneDeviation]
    var heartRateData: [HeartRatePoint]
    
    struct LaneDeviation: Codable {
        let timestamp: Date
        let deviation: Double // in meters from center
    }
    
    struct HeartRatePoint: Codable {
        let timestamp: Date
        let beatsPerMinute: Double
    }
}