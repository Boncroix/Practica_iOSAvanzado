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
    
    let keychain = KeychainSwift()
    let keyToken = "keyToken"
    
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


