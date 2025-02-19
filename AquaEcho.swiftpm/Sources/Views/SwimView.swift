import SwiftUI
import CoreMotion

struct SwimView: View {
    @EnvironmentObject var motionManager: MotionManager
    @EnvironmentObject var audioFeedback: AudioFeedback
    @EnvironmentObject var hapticFeedback: HapticFeedback
    @StateObject private var sessionManager = SwimSessionManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if sessionManager.isSessionActive {
                    ActiveSwimView(sessionManager: sessionManager)
                } else {
                    PreSwimView(sessionManager: sessionManager)
                }
            }
            .navigationTitle("Swim")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct ActiveSwimView: View {
    @ObservedObject var sessionManager: SwimSessionManager
    @EnvironmentObject var motionManager: MotionManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 24) {
            // Session Timer
            Text(formatDuration(sessionManager.sessionDuration))
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 5)
                )
            
            // Lane Position Indicator with enhanced visuals
            VStack(spacing: 12) {
                Text("Lane Position")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                ZStack {
                    // Lane boundaries
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 3)
                        .frame(height: 120)
                        .overlay(
                            // Grid lines
                            HStack(spacing: 0) {
                                ForEach(0..<5) { _ in
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.1))
                                        .frame(width: 1)
                                    Spacer()
                                }
                            }
                        )
                    
                    // Center line
                    Rectangle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 2)
                    
                    // Position indicator
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 24, height: 24)
                        .shadow(color: .blue.opacity(0.5), radius: 5)
                        .offset(x: CGFloat(motionManager.lateralDrift * 100))
                        .animation(.spring(response: 0.3), value: motionManager.lateralDrift)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 5)
                )
            }
            
            // Session Stats with enhanced visuals
            HStack(spacing: 20) {
                StatBox(
                    title: "Laps",
                    value: "\(sessionManager.lapCount)",
                    icon: "arrow.triangle.turn.up.right.circle.fill",
                    color: .blue
                )
                
                StatBox(
                    title: "Distance",
                    value: String(format: "%.0fm", sessionManager.distance),
                    icon: "ruler.fill",
                    color: .green
                )
            }
            .padding(.horizontal)
            
            Spacer()
            
            // End Session Button with animation
            Button(action: sessionManager.endSession) {
                HStack {
                    Image(systemName: "stop.circle.fill")
                        .font(.title2)
                    Text("End Session")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.red, .orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .padding()
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct PreSwimView: View {
    @ObservedObject var sessionManager: SwimSessionManager
    @State private var showingCalibration = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 40) {
            // Hero Image
            Image(systemName: "figure.pool.swim")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .cyan]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding()
                .background(
                    Circle()
                        .fill(Color(.systemBackground))
                        .shadow(radius: 10)
                )
            
            VStack(spacing: 24) {
                // Calibration Button
                Button(action: { showingCalibration = true }) {
                    HStack {
                        Image(systemName: "ruler")
                            .font(.title2)
                        Text("Calibrate Position")
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
                
                // Start Swimming Button
                Button(action: sessionManager.startSession) {
                    HStack {
                        Image(systemName: "play.fill")
                            .font(.title2)
                        Text("Start Swimming")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                }
            }
            .padding(.horizontal, 32)
        }
        .sheet(isPresented: $showingCalibration) {
            CalibrationView()
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.subheadline)
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
