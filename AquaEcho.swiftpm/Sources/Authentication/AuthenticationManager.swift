import SwiftUI
import AuthenticationServices
import CloudKit

class AuthenticationManager: NSObject, ObservableObject {
    @Published var isAuthenticated = false
    @Published var userProfile: UserProfile?
    private let keychain = KeychainManager.shared
    
    override init() {
        super.init()
        checkExistingAuthentication()
    }
    
    private func checkExistingAuthentication() {
        if let userId = keychain.retrieveUserId(),
           let token = keychain.retrieveAuthToken() {
            validateToken(userId: userId, token: token)
        }
    }
    
    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = UIApplication.shared.windows.first?.rootViewController as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    func signOut() {
        keychain.deleteAuthToken()
        keychain.deleteUserId()
        isAuthenticated = false
        userProfile = nil
    }
    
    private func validateToken(userId: String, token: String) {
        // Implement token validation with your backend
        // For now, we'll assume the token is valid
        isAuthenticated = true
    }
}

extension AuthenticationManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId = appleIDCredential.user
            let identityToken = appleIDCredential.identityToken
            let authCode = appleIDCredential.authorizationCode
            
            // Store credentials securely
            keychain.storeUserId(userId)
            if let token = String(data: identityToken!, encoding: .utf8) {
                keychain.storeAuthToken(token)
            }
            
            // Create user profile
            let profile = UserProfile(
                id: userId,
                name: appleIDCredential.fullName?.givenName,
                email: appleIDCredential.email
            )
            
            DispatchQueue.main.async {
                self.userProfile = profile
                self.isAuthenticated = true
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authentication error: \(error.localizedDescription)")
    }
}
