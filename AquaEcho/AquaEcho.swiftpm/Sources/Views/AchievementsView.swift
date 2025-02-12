import SwiftUI

struct AchievementsView: View {
    struct Achievement: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let icon: String
        let isUnlocked: Bool
        let progress: Double // 0 to 1
    }
    
    let achievements = [
        Achievement(
            title: "Early Bird",
            description: "Complete 5 morning swims",
            icon: "sunrise.fill",
            isUnlocked: true,
            progress: 1.0
        ),
        Achievement(
            title: "Marathon Swimmer",
            description: "Swim 10km in total",
            icon: "figure.pool.swim",
            isUnlocked: false,
            progress: 0.7
        ),
        Achievement(
            title: "Perfect Form",
            description: "Maintain center lane position for entire session",
            icon: "checkmark.circle.fill",
            isUnlocked: false,
            progress: 0.3
        )
    ]
    
    var body: some View {
        List(achievements) { achievement in
            HStack {
                Image(systemName: achievement.icon)
                    .font(.title2)
                    .foregroundColor(achievement.isUnlocked ? .blue : .gray)
                    .frame(width: 40)
                
                VStack(alignment: .leading) {
                    Text(achievement.title)
                        .font(.headline)
                    Text(achievement.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: achievement.progress)
                        .tint(achievement.isUnlocked ? .blue : .gray)
                }
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("Achievements")
    }
}
