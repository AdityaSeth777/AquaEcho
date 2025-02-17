import SwiftUI

struct SessionStatsView: View {
    let duration: TimeInterval
    let laps: Int
    let distance: Double
    
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            StatItem(title: "Time", value: formattedDuration, icon: "clock.fill")
            StatItem(title: "Laps", value: "\(laps)", icon: "arrow.triangle.turn.up.right.circle.fill")
            StatItem(title: "Distance", value: String(format: "%.0fm", distance), icon: "ruler.fill")
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct StatItem: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
            
            Text(value)
                .font(.headline)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}