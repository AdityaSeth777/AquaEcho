import SwiftUI
import HealthKit

@main
struct AquaEchoApp: App {
    @StateObject private var motionManager = MotionManager()
    @StateObject private var audioFeedback = AudioFeedback()
    @StateObject private var hapticFeedback = HapticFeedback()
    @StateObject private var healthKitManager = HealthKitManager()
    @StateObject private var authManager = AuthenticationManager()
    @StateObject private var settingsManager = SettingsManager()
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
                    .environmentObject(motionManager)
                    .environmentObject(audioFeedback)
                    .environmentObject(hapticFeedback)
                    .environmentObject(healthKitManager)
                    .environmentObject(authManager)
                    .environmentObject(settingsManager)
                    .onAppear {
                        healthKitManager.requestAuthorization()
                    }
            } else {
                AuthenticationView()
                    .environmentObject(authManager)
            }
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            SwimView()
                .tabItem {
                    Label("Swim", systemImage: "figure.pool.swim")
                }
            
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
