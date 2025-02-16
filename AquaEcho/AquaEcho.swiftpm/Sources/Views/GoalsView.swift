import SwiftUI

struct GoalsView: View {
    @State private var weeklyDistance = 1000.0
    @State private var weeklyLaps = 40
    @State private var targetPace: TimeInterval = 120 // 2 minutes per 100m
    
    var body: some View {
        Form {
            Section(header: Text("Weekly Goals")) {
                VStack(alignment: .leading) {
                    Text("Distance (meters)")
                    Slider(value: $weeklyDistance, in: 500...5000, step: 100) {
                        Text("Weekly Distance Goal")
                    }
                    Text("\(Int(weeklyDistance))m")
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading) {
                    Text("Number of Laps")
                    Slider(value: Binding(
                        get: { Double(weeklyLaps) },
                        set: { weeklyLaps = Int($0) }
                    ), in: 20...200, step: 5) {
                        Text("Weekly Laps Goal")
                    }
                    Text("\(weeklyLaps) laps")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("Performance")) {
                VStack(alignment: .leading) {
                    Text("Target Pace (per 100m)")
                    Slider(value: $targetPace, in: 60...300, step: 5) {
                        Text("Target Pace")
                    }
                    Text(formatPace(targetPace))
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Swimming Goals")
    }
    
    private func formatPace(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%d:%02d /100m", minutes, remainingSeconds)
    }
}

// Remove the Double extension as it's no longer needed
