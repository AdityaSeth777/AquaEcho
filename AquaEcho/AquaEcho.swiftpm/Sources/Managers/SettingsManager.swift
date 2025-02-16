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
        
        // Set default values if not already set
        if poolLength == 0 {
            poolLength = 25 // Default to 25 meters
            UserDefaults.standard.set(poolLength, forKey: "poolLength")
        }
        
        if !UserDefaults.standard.contains(key: "goalReminders") {
            goalReminders = true
            UserDefaults.standard.set(true, forKey: "goalReminders")
        }
        
        if !UserDefaults.standard.contains(key: "achievementAlerts") {
            achievementAlerts = true
            UserDefaults.standard.set(true, forKey: "achievementAlerts")
        }
    }
    
    func resetToDefaults() {
        poolLength = 25
        goalReminders = true
        achievementAlerts = true
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
