import SwiftUI

struct CalibrationView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var motionManager: MotionManager
    @State private var calibrationStep = 0
    @State private var showingSuccess = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                // Animated Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue.opacity(0.1), .cyan.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 160, height: 160)
                    
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 160, height: 160)
                        .rotationEffect(.degrees(rotationAngle))
                    
                    Image(systemName: calibrationStep == 0 ? "figure.pool.swim" : "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .padding()
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                }
                
                if calibrationStep == 0 {
                    VStack(spacing: 24) {
                        Text("Position Calibration")
                            .font(.title2)
                            .bold()
                        
                        Text("Hold your device in swimming position and stay in the center of your lane")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        // Instructions Card
                        VStack(alignment: .leading, spacing: 16) {
                            InstructionRow(
                                number: "1",
                                text: "Stand in the center of your lane",
                                icon: "figure.stand"
                            )
                            
                            InstructionRow(
                                number: "2",
                                text: "Hold device in swimming position",
                                icon: "iphone"
                            )
                            
                            InstructionRow(
                                number: "3",
                                text: "Stay still during calibration",
                                icon: "hand.raised.fill"
                            )
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 5)
                        )
                        .padding(.horizontal)
                        
                        Button(action: {
                            withAnimation {
                                motionManager.calibrate()
                                calibrationStep = 1
                                showingSuccess = true
                            }
                        }) {
                            HStack {
                                Image(systemName: "ruler")
                                    .font(.title2)
                                Text("Start Calibration")
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
                        .padding(.top, 16)
                    }
                } else {
                    VStack(spacing: 24) {
                        Text("Calibration Complete!")
                            .font(.title2)
                            .bold()
                        
                        Text("Your device is now calibrated for accurate lane position tracking")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        // Success Card
                        VStack(spacing: 16) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 48))
                                .foregroundColor(.green)
                            
                            Text("Ready to Swim")
                                .font(.headline)
                            
                            Text("Your device will now track your position in the lane")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 5)
                        )
                        .padding(.horizontal)
                        
                        Button(action: {
                            dismiss()
                        }) {
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
                        .padding(.horizontal, 32)
                        .padding(.top, 16)
                    }
                }
            }
            .padding(.vertical)
            .navigationTitle("Calibration")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: { dismiss() }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
            )
        }
    }
}

struct InstructionRow: View {
    let number: String
    let text: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Step Number
            Text(number)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue, .cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
            
            // Instruction Text
            Text(text)
                .font(.subheadline)
            
            Spacer()
            
            // Icon
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
        }
    }
}
