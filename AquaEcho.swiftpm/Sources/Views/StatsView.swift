import SwiftUI
import HealthKit

struct StatsView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @State private var selectedTimeFrame: TimeFrame = .week
    @State private var showingShareSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Time Frame Picker with enhanced styling
                    Picker("Time Frame", selection: $selectedTimeFrame) {
                        ForEach(TimeFrame.allCases, id: \.self) { timeFrame in
                            Text(timeFrame.rawValue.capitalized)
                                .tag(timeFrame)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Summary Card
                    let stats = healthKitManager.calculateStats(for: selectedTimeFrame)
                    SummaryCard(stats: stats, timeFrame: selectedTimeFrame)
                    
                    // Stats Grid with enhanced visuals
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {
                        StatCard(
                            title: "Total Distance",
                            value: String(format: "%.0fm", stats.totalDistance),
                            icon: "figure.pool.swim",
                            color: .blue
                        )
                        
                        StatCard(
                            title: "Avg. Pace",
                            value: formatPace(stats.averagePace),
                            icon: "speedometer",
                            color: .orange
                        )
                        
                        StatCard(
                            title: "Total Time",
                            value: formatDuration(stats.totalDuration),
                            icon: "clock.fill",
                            color: .purple
                        )
                        
                        StatCard(
                            title: "Calories",
                            value: "350 kcal",
                            icon: "flame.fill",
                            color: .red
                        )
                    }
                    .padding(.horizontal)
                    
                    // Recent Sessions List
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Sessions")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            Button(action: { showingShareSheet = true }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        if !healthKitManager.swimSessions.isEmpty {
                            ForEach(healthKitManager.swimSessions, id: \.uuid) { session in
                                NavigationLink(destination: SessionDetailView(session: session)) {
                                    SessionRow(session: session)
                                }
                            }
                        } else {
                            NoDataView()
                        }
                    }
                }
                .padding(.vertical)
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

struct SummaryCard: View {
    let stats: SwimStats
    let timeFrame: TimeFrame
    
    var body: some View {
        VStack(spacing: 16) {
            Text("\(timeFrame.rawValue.capitalized) Summary")
                .font(.headline)
            
            HStack(spacing: 24) {
                Spacer()
                
                VStack(spacing: 8) {
                    Text("\(Int(stats.totalDistance))")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    Text("meters")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                    .frame(height: 40)
                
                VStack(spacing: 8) {
                    Text(formatDuration(stats.totalDuration))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    Text("total time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return hours > 0 ? String(format: "%dh %dm", hours, minutes) : String(format: "%dm", minutes)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
    }
}

struct SessionRow: View {
    let session: HKWorkout
    
    var body: some View {
        HStack(spacing: 16) {
            // Session Icon
            Circle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.blue, .cyan]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "figure.pool.swim")
                        .font(.title3)
                        .foregroundColor(.white)
                )
            
            // Session Details
            VStack(alignment: .leading, spacing: 4) {
                Text(session.startDate, style: .date)
                    .font(.headline)
                
                HStack {
                    Label("\(Int(session.duration / 60))m", systemImage: "clock.fill")
                    
                    if let distance = session.totalDistance?.doubleValue(for: .meter()) {
                        Label("\(Int(distance))m", systemImage: "ruler.fill")
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
        .padding(.horizontal)
    }
}

struct NoDataView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "figure.pool.swim")
                .font(.system(size: 48))
                .foregroundColor(.blue)
            
            Text("No Swimming Sessions")
                .font(.headline)
            
            Text("Complete your first swim to see your statistics")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}
