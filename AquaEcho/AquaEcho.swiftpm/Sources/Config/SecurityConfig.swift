import Foundation
import Security
import LocalAuthentication

struct SecurityConfig {
    // Authentication settings
    static let authConfig = AuthenticationConfiguration(
        biometricAuthEnabled: true,
        requiredBiometricLevel: .any,
        fallbackToPasscode: true,
        sessionTimeout: 3600 // 1 hour
    )
    
    // Keychain settings
    static let keychainConfig = KeychainConfiguration(
        accessGroup: "group.com.aquaecho.app",
        accessibility: kSecAttrAccessibleAfterFirstUnlock,
        synchronizable: true
    )
    
    // Encryption settings
    static let encryptionConfig = EncryptionConfiguration(
        algorithm: .aes256,
        keySize: 256,
        useSecureEnclave: true,
        ivSize: 16
    )
    
    // Privacy settings
    static let privacyConfig = PrivacyConfiguration(
        dataRetentionPeriod: 90 * 24 * 60 * 60, // 90 days
        anonymizeData: true,
        healthKitSync: true
    )
}

struct AuthenticationConfiguration {
    let biometricAuthEnabled: Bool
    let requiredBiometricLevel: LABiometryType
    let fallbackToPasscode: Bool
    let sessionTimeout: TimeInterval
}

struct KeychainConfiguration {
    let accessGroup: String
    let accessibility: CFString
    let synchronizable: Bool
}

struct EncryptionConfiguration {
    enum Algorithm {
        case aes256
        case chacha20
    }
    
    let algorithm: Algorithm
    let keySize: Int
    let useSecureEnclave: Bool
    let ivSize: Int
}

struct PrivacyConfiguration {
    let dataRetentionPeriod: TimeInterval
    let anonymizeData: Bool
    let healthKitSync: Bool
}
