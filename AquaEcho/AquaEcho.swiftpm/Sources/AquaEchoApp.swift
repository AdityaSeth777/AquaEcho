import SwiftUI

@main
struct AquaEchoApp: App {
    @StateObject private var motionManager = MotionManager()
    @StateObject private var audioFeedback = AudioFeedback()
    @StateObject private var hapticFeedback = HapticFeedback()
    @StateObject private var healthKitManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(motionManager)
                .environmentObject(audioFeedback)
                .environmentObject(hapticFeedback)
                .environmentObject(healthKitManager)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var motionManager: MotionManager
    @EnvironmentObject var audioFeedback: AudioFeedback
    @EnvironmentObject var hapticFeedback: HapticFeedback
    @EnvironmentObject var healthKitManager: HealthKitManager
    
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
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}