import SwiftUI

struct LanePositionView: View {
    let drift: Double
    
    var body: some View {
        VStack {
            Text("Lane Position")
                .font(.headline)
            
            ZStack {
                // Lane boundaries
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                    .frame(height: 100)
                
                // Center line
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 2)
                
                // Position indicator
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                    .offset(x: CGFloat(drift * 100))
                    .animation(.spring(), value: drift)
            }
            .padding()
        }
    }
}