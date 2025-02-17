import SwiftUI
import HealthKit

struct SessionDetailView: View {
    let session: HKWorkout
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Session Overview
                VStack(spacing: 8) {
                    Text(session.startDate, style: .date)
                        .font(.headline)
                    Text(session.startDate, style: .time)
                        .foregroundColor(.secondary)
                }
                
                // Stats Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    StatCard(
                        title: "Duration",
                        value: formatDuration(session.duration),
                        icon: "clock.fill"
                    )
                    
                    if let distance = session.totalDistance?.doubleValue(for: .meter()) {
                        StatCard(
                            title: "Distance",
                            value: "\(Int(distance))m",
                            icon: "figure.pool.swim"
                        )
                    }
                    
                    if let energy = session.totalEnergyBurned?.doubleValue(for: .kilocalorie()) {
                        StatCard(
                            title: "Calories",
                            value: "\(Int(energy))kcal",
                            icon: "flame.fill"
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Session Details")
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}