import SwiftUI

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
            
            ForEach(healthKitManager.swimSessions, id: \.uuid) { session in
                NavigationLink(destination: SessionDetailView(session: session)) {
                    SessionRow(session: session)
                }
            }
        }
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