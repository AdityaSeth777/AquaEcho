import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms of Service")
                    .font(.largeTitle)
                    .bold()
                
                Group {
                    Text("1. Acceptance of Terms")
                        .font(.headline)
                    Text("By using AquaEcho, you agree to these terms. If you disagree with any part, please discontinue use of the app.")
                    
                    Text("2. Use License")
                        .font(.headline)
                    Text("AquaEcho grants you a personal, non-transferable license to use the app for personal fitness tracking.")
                    
                    Text("3. Disclaimer")
                        .font(.headline)
                    Text("AquaEcho is provided 'as is' without warranties. Always exercise caution and follow pool safety guidelines.")
                    
                    Text("4. Limitations")
                        .font(.headline)
                    Text("We are not liable for any injuries or accidents that may occur while using the app.")
                }
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
    }
}