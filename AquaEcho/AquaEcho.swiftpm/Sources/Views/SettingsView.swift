import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var audioFeedback: AudioFeedback
    @EnvironmentObject var hapticFeedback: HapticFeedback
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Feedback")) {
                    Toggle("Audio Feedback", isOn: $audioFeedback.isEnabled)
                    Toggle("Haptic Feedback", isOn: $hapticFeedback.isEnabled)
                }
                
                Section(header: Text("Pool Settings")) {
                    Picker("Pool Length", selection: $settingsManager.poolLength) {
                        Text("25 meters").tag(25)
                        Text("50 meters").tag(50)
                        Text("25 yards").tag(23)
                    }
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Goal Reminders", isOn: $settingsManager.goalReminders)
                    Toggle("Achievement Alerts", isOn: $settingsManager.achievementAlerts)
                }
                
                Section(header: Text("App")) {
                    NavigationLink("Privacy Policy") {
                        PrivacyPolicyView()
                    }
                    NavigationLink("Terms of Service") {
                        TermsOfServiceView()
                    }
                    NavigationLink("About") {
                        AboutView()
                    }
                }
                
                Section {
                    Button("Reset All Settings") {
                        settingsManager.resetToDefaults()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
