import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "wave.3.right.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("AquaEcho")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your Smart Swimming Assistant")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Spacer()
            
            VStack(spacing: 20) {
                SignInWithAppleButton(
                    .signIn,
                    onRequest: { _ in },
                    onCompletion: { result in
                        switch result {
                        case .success:
                            authManager.signInWithApple()
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                )
                .frame(height: 50)
                .padding(.horizontal)
                
                Text("By continuing, you agree to our Terms of Service and Privacy Policy")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}