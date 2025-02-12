import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .bold()
                
                Group {
                    Text("Data Collection")
                        .font(.headline)
                    Text("AquaEcho collects motion data, swimming metrics, and health information to provide real-time guidance and tracking. All data is stored locally on your device or in HealthKit.")
                    
                    Text("Data Usage")
                        .font(.headline)
                    Text("Your data is used exclusively to provide swimming guidance and analytics. We do not share your information with third parties.")
                    
                    Text("Data Protection")
                        .font(.headline)
                    Text("We use industry-standard security measures to protect your data. Authentication is handled through Sign in with Apple for maximum security.")
                    
                    Text("Your Rights")
                        .font(.headline)
                    Text("You can access, modify, or delete your data at any time through the app settings. You can also export your data in a portable format.")
                }
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}
