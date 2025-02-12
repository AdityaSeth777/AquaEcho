import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "wave.3.right.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                
                Text("AquaEcho")
                    .font(.largeTitle)
                    .bold()
                
                Text("Version 1.0.0")
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 15) {
                    InfoSection(title: "About", content: "AquaEcho is a revolutionary swimming assistant that helps visually impaired and competitive swimmers stay on course using audio and haptic feedback.")
                    
                    InfoSection(title: "Features", content: "• Real-time lane guidance\n• Spatial audio feedback\n• Haptic alerts\n• Swim tracking\n• HealthKit integration")
                    
                    InfoSection(title: "Support", content: "For support, please contact:\nsupport@aquaecho.com")
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("About")
    }
}

struct InfoSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(content)
                .foregroundColor(.secondary)
        }
    }
}
