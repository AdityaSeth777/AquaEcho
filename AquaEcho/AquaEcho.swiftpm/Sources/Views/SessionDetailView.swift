import SwiftUI
import HealthKit
import Charts

struct SessionDetailView: View {
    let session: HKWorkout
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Session Header
                VStack(spacing: 8) {
                    Text(session.startDate, style: .date)
                        .font(.title2)
                        .bold()
                    
                    Text(session.startDate, style: .time)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue.opacity(0.1), .cyan.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .padding(.horizontal)
                
                // Stats Grid
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 16
                ) {
                    DetailStatCard(
                        title: "Duration",
                        value: formatDuration(session.duration),
                        icon: "clock.fill",
                        color: .blue
                    )
                    
                    if let distance = session.totalDistance?.doubleValue(for: .meter()) {
                        DetailStatCard(
                            title: "Distance",
                            value: "\(Int(distance))m",
                            icon: "figure.pool.swim",
                            color: .green
                        )
                    }
                    
                    if let energy = session.totalEnergyBurned?.doubleValue(for: .kilocalorie()) {
                        DetailStatCard(
                            title: "Calories",
                            value: "\(Int(energy))kcal",
                            icon: "flame.fill",
                            color: .orange
                        )
                    }
                    
                    DetailStatCard(
                        title: "Avg. Pace",
                        value: calculatePace(),
                        icon: "speedometer",
                        color: .purple
                    )
                }
                .padding(.horizontal)
                
                // Performance Insights
                VStack(alignment: .leading, spacing: 16) {
                    Text("Performance Insights")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            InsightCard(
                                title: "Great Pace!",
                                description: "Your pace was 5% faster than your average",
                                icon: "bolt.fill",
                                color: .yellow
                            )
                            
                            InsightCard(
                                title: "New Achievement",
                                description: "Longest continuous swim session",
                                icon: "trophy.fill",
                                color: .orange
                            )
                            
                            InsightCard(
                                title: "Consistent Form",
                                description: "Maintained steady lane position",
                                icon: "checkmark.circle.fill",
                                color: .green
                            )
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Lane Position Chart
                VStack(alignment: .leading, spacing: 16) {
                    Text("Lane Position")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    LanePositionChart()
                        .frame(height: 200)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 5)
                        )
                        .padding(.horizontal)
                }
                
                // Share Button
                Button(action: {
                    // Share functionality
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                        Text("Share Session")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .cyan]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 32)
                .padding(.top, 8)
            }
            .padding(.vertical)
        }
        .navigationTitle("Session Details")
        .background(Color(.systemGroupedBackground))
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func calculatePace() -> String {
        guard let distance = session.totalDistance?.doubleValue(for: .meter()),
              distance > 0 else { return "--:--" }
        
        let pacePerHundred = (session.duration / distance) * 100
        let minutes = Int(pacePerHundred) / 60
        let seconds = Int(pacePerHundred) % 60
        return String(format: "%d:%02d/100m", minutes, seconds)
    }
}

struct DetailStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .fill(color.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(color)
                )
            
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

struct InsightCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.headline)
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 200)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
        )
    }
}

struct LanePositionChart: View {
    // Sample data for demonstration
    let data: [(Double, Double)] = [
        (0, 0), (5, 0.2), (10, -0.1), (15, 0.3),
        (20, 0.1), (25, -0.2), (30, 0), (35, 0.1)
    ]
    
    var body: some View {
        Chart {
            ForEach(data, id: \.0) { point in
                LineMark(
                    x: .value("Time", point.0),
                    y: .value("Position", point.1)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .cyan]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
        }
        .chartYScale(domain: -1...1)
        .chartYAxis {
            AxisMarks(values: [-1, -0.5, 0, 0.5, 1]) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    Text("\(value.as(Double.self)!, specifier: "%.1f")m")
                        .font(.caption)
                }
            }
        }
    }
}
