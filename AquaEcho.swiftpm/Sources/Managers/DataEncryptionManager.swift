import Foundation
import CryptoKit
import Security

class DataEncryptionManager {
    static let shared = DataEncryptionManager()
    
    private let keychain = KeychainManager.shared
    private let securityConfig = SecurityConfig.encryptionConfig
    
    private init() {} // Make initializer private for singleton
    
    // MARK: - Encryption
    
    func encrypt(_ data: Data) throws -> Data {
        let key = try getOrCreateKey()
        let nonce = try generateNonce()
        
        switch securityConfig.algorithm {
        case .aes256:
            return try encryptAES256(data: data, key: key, nonce: nonce)
        case .chacha20:
            return try encryptChacha20(data: data, key: key, nonce: nonce)
        }
    }
    
    func decrypt(_ encryptedData: Data) throws -> Data {
        let key = try getOrCreateKey()
        
        // Extract nonce from encrypted data
        let nonceSize = securityConfig.ivSize
        let nonce = encryptedData.prefix(nonceSize)
        let ciphertext = encryptedData.dropFirst(nonceSize)
        
        switch securityConfig.algorithm {
        case .aes256:
            return try decryptAES256(ciphertext: ciphertext, key: key, nonce: nonce)
        case .chacha20:
            return try decryptChacha20(ciphertext: ciphertext, key: key, nonce: nonce)
        }
    }
    
    // MARK: - Private Methods
    
    private func getOrCreateKey() throws -> SymmetricKey {
        if let existingKey = try? keychain.retrieveKey() {
            return existingKey
        }
        
        let newKey = SymmetricKey(size: .bits256)
        try keychain.storeKey(newKey)
        return newKey
    }
    
    private func generateNonce() throws -> Data {
        var nonce = Data(count: securityConfig.ivSize)
        let result = nonce.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, securityConfig.ivSize, $0.baseAddress!)
        }
        
        guard result == errSecSuccess else {
            throw CryptoError.nonceGenerationFailed
        }
        
        return nonce
    }
    
    private func encryptAES256(data: Data, key: SymmetricKey, nonce: Data) throws -> Data {
        guard let nonceData = try? nonce.withUnsafeBytes({ bytes in
            return Data(bytes: bytes, count: securityConfig.ivSize)
        }) else {
            throw CryptoError.encryptionFailed
        }
        
        let sealedBox = try AES.GCM.seal(data, using: key, nonce: AES.GCM.Nonce(data: nonceData))
        
        // Combine nonce and encrypted data
        var encryptedData = Data()
        encryptedData.append(nonceData)
        encryptedData.append(sealedBox.ciphertext)
        encryptedData.append(sealedBox.tag)
        
        return encryptedData
    }
    
    private func decryptAES256(ciphertext: Data, key: SymmetricKey, nonce: Data) throws -> Data {
        let tagSize = 16
        let actualCiphertext = ciphertext.dropLast(tagSize)
        let tag = ciphertext.suffix(tagSize)
        
        let sealedBox = try AES.GCM.SealedBox(
            nonce: AES.GCM.Nonce(data: nonce),
            ciphertext: actualCiphertext,
            tag: tag
        )
        
        return try AES.GCM.open(sealedBox, using: key)
    }
    
    private func encryptChacha20(data: Data, key: SymmetricKey, nonce: Data) throws -> Data {
        guard let nonceData = try? nonce.withUnsafeBytes({ bytes in
            return Data(bytes: bytes, count: securityConfig.ivSize)
        }) else {
            throw CryptoError.encryptionFailed
        }
        
        let sealedBox = try ChaChaPoly.seal(data, using: key, nonce: ChaChaPoly.Nonce(data: nonceData))
        
        var encryptedData = Data()
        encryptedData.append(nonceData)
        encryptedData.append(sealedBox.ciphertext)
        encryptedData.append(sealedBox.tag)
        
        return encryptedData
    }
    
    private func decryptChacha20(ciphertext: Data, key: SymmetricKey, nonce: Data) throws -> Data {
        let tagSize = 16
        let actualCiphertext = ciphertext.dropLast(tagSize)
        let tag = ciphertext.suffix(tagSize)
        
        let sealedBox = try ChaChaPoly.SealedBox(
            nonce: ChaChaPoly.Nonce(data: nonce),
            ciphertext: actualCiphertext,
            tag: tag
        )
        
        return try ChaChaPoly.open(sealedBox, using: key)
    }
}

enum CryptoError: Error {
    case keyGenerationFailed
    case nonceGenerationFailed
    case encryptionFailed
    case decryptionFailed
}
