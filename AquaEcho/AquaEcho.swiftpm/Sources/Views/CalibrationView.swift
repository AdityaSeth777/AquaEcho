import SwiftUI

struct CalibrationView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var motionManager: MotionManager
    @State private var calibrationStep = 0
    @State private var showingSuccess = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image(systemName: calibrationStep == 0 ? "figure.pool.swim" : "checkmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .animation(.spring(), value: calibrationStep)
                
                if calibrationStep == 0 {
                    VStack(spacing: 20) {
                        Text("Position Calibration")
                            .font(.title2)
                            .bold()
                        
                        Text("Hold your device in swimming position and stay in the center of your lane")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            motionManager.calibrate()
                            calibrationStep = 1
                            showingSuccess = true
                        }) {
                            Text("Start Calibration")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                } else {
                    VStack(spacing: 20) {
                        Text("Calibration Complete!")
                            .font(.title2)
                            .bold()
                        
                        Text("Your device is now calibrated for accurate lane position tracking")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Calibration")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            })
        }
    }
}
