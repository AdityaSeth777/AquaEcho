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
        }
    }
}

struct ActiveSwimView: View {
    @ObservedObject var sessionManager: SwimSessionManager
    @EnvironmentObject var motionManager: MotionManager
    
    var body: some View {
        VStack(spacing: 20) {
            // Lane Position Indicator
            LanePositionView(drift: motionManager.lateralDrift)
            
            // Session Stats
            SessionStatsView(
                duration: sessionManager.sessionDuration,
                laps: sessionManager.lapCount,
                distance: sessionManager.distance
            )
            
            // Controls
            Button(action: sessionManager.endSession) {
                Text("End Session")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
    }
}

struct PreSwimView: View {
    @ObservedObject var sessionManager: SwimSessionManager
    @State private var showingCalibration = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "figure.pool.swim")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .foregroundColor(.blue)
            
            VStack(spacing: 10) {
                Button(action: { showingCalibration = true }) {
                    Label("Calibrate Position", systemImage: "ruler")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: sessionManager.startSession) {
                    Label("Start Swimming", systemImage: "play.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showingCalibration) {
            CalibrationView()
        }
    }
}