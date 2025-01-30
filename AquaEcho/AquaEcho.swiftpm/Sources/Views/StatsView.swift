import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @State private var selectedTimeFrame: TimeFrame = .week
    
    enum TimeFrame: String, CaseIterable {
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
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
                    
                    // Stats Cards
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        StatCard(title: "Total Distance", value: "1,500m", icon: "figure.pool.swim")
                        StatCard(title: "Avg. Pace", value: "2:15/100m", icon: "speedometer")
                        StatCard(title: "Total Time", value: "45:30", icon: "clock.fill")
                        StatCard(title: "Calories", value: "450", icon: "flame.fill")
                    }
                    .padding(.horizontal)
                    
                    // Charts
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Distance Over Time")
                            .font(.headline)
                        
                        Chart {
                            // Implementation of distance chart
                        }
                        .frame(height: 200)
                    }
                    .padding()
                    
                    // Recent Sessions
                    RecentSessionsList()
                }
            }
            .navigationTitle("Statistics")
        }
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

struct RecentSessionsList: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Sessions")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(healthKitManager.swimSessions) { session in
                NavigationLink(destination: SessionDetailView(session: session)) {
                    SessionRow(session: session)
                }
            }
        }
    }
}