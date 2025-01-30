import SwiftUI

class SettingsManager: ObservableObject {
    @Published var poolLength: Int {
        didSet {
            UserDefaults.standard.set(poolLength, forKey: "poolLength")
        }
    }
    
    @Published var goalReminders: Bool {
        didSet {
            UserDefaults.standard.set(goalReminders, forKey: "goalReminders")
        }
    }
    
    @Published var achievementAlerts: Bool {
        didSet {
            UserDefaults.standard.set(achievementAlerts, forKey: "achievementAlerts")
        }
    }
    
    init() {
        self.poolLength = UserDefaults.standard.integer(forKey: "poolLength")
        self.goalReminders = UserDefaults.standard.bool(forKey: "goalReminders")
        self.achievementAlerts = UserDefaults.standard.bool(forKey: "achievementAlerts")
        
        if poolLength == 0 {
            poolLength = 25 // Default to 25 meters
        }
    }
    
    func resetToDefaults() {
        poolLength = 25
        goalReminders = true
        achievementAlerts = true
    }
}