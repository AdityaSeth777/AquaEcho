import SwiftUI
import HealthKit

struct StatsView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @State private var selectedTimeFrame: TimeFrame = .week
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Time Frame Picker
                    Picker("Time Frame", selection: $selectedTimeFrame) {
                        ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                            Text(timeFrame.rawValue).tag(timeFrame)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Stats Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        let stats = healthKitManager.calculateStats(for: selectedTimeFrame)
                        
                        StatCard(
                            title: "Total Distance",
                            value: String(format: "%.0fm", stats.totalDistance),
                            icon: "figure.pool.swim"
                        )
                        
                        StatCard(
                            title: "Avg. Pace",
                            value: formatPace(stats.averagePace),
                            icon: "speedometer"
                        )
                        
                        StatCard(
                            title: "Total Time",
                            value: formatDuration(stats.totalDuration),
                            icon: "clock.fill"
                        )
                    }
                    .padding(.horizontal)
                    
                    // Recent Sessions
                    if !healthKitManager.swimSessions.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Recent Sessions")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(healthKitManager.swimSessions, id: \.uuid) { session in
                                NavigationLink(destination: SessionDetailView(session: session)) {
                                    SessionRow(session: session)
                                }
                            }
                        }
                    } else {
                        Text("No swimming sessions recorded yet")
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
            }
            .navigationTitle("Statistics")
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private func formatPace(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%d:%02d/100m", minutes, remainingSeconds)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct SessionRow: View {
    let session: HKWorkout
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(session.startDate, style: .date)
                    .font(.headline)
                Text("\(Int(session.duration / 60)) minutes")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if let distance = session.totalDistance?.doubleValue(for: .meter()) {
                    Text("\(Int(distance))m")
                        .font(.headline)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
        .padding(.horizontal)
    }
}
