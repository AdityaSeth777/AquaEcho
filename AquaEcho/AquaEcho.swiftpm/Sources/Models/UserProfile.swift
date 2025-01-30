import Foundation

struct UserProfile: Codable, Identifiable {
    let id: String
    var name: String?
    var email: String?
    var preferredStrokeStyle: StrokeStyle?
    var poolLength: Int?
    var goals: SwimGoals?
    
    enum StrokeStyle: String, Codable, CaseIterable {
        case freestyle
        case backstroke
        case breaststroke
        case butterfly
    }
}

struct SwimGoals: Codable {
    var weeklyDistance: Double
    var weeklyLaps: Int
    var targetPace: TimeInterval
}