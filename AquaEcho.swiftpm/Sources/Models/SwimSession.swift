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
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        duration: TimeInterval,
        distance: Double,
        laps: Int,
        strokeStyle: UserProfile.StrokeStyle = .freestyle,
        laneDeviations: [LaneDeviation] = [],
        heartRateData: [HeartRatePoint] = []
    ) {
        self.id = id
        self.date = date
        self.duration = duration
        self.distance = distance
        self.laps = laps
        self.strokeStyle = strokeStyle
        self.averagePace = duration / (distance / 100) // pace per 100m
        self.laneDeviations = laneDeviations
        self.heartRateData = heartRateData
    }
    
    struct LaneDeviation: Codable {
        let timestamp: Date
        let deviation: Double // in meters from center
    }
    
    struct HeartRatePoint: Codable {
        let timestamp: Date
        let beatsPerMinute: Double
    }
}
