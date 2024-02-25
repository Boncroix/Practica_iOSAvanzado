//
//  SecureDataProvider.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 25/2/24.
//

import Foundation
import KeychainSwift

protocol SecureDataKeychainProtocol {
    func setToken(token: String)
    func getToken() -> String?
    func deleteToken()
}


struct SecureDataKeychain: SecureDataKeychainProtocol {
    
    private let keychain = KeychainSwift()
    private let keyToken = "keyToken"
    
    func setToken(token: String) {
        keychain.set(token, forKey: keyToken)
    }
    
    func getToken() -> String? {
        keychain.get(keyToken)
    }
    
    func deleteToken() {
        keychain.delete(keyToken)
    }
}

struct SecureDataUserDefaults: SecureDataKeychainProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let keyToken = "keyToken"
    
    func setToken(token: String) {
        userDefaults.setValue(token, forKey: keyToken)
    }
    
    func getToken() -> String? {
        userDefaults.value(forKey: keyToken) as? String
    }
    
    func deleteToken() {
        userDefaults.removeObject(forKey: keyToken)
    }
}
