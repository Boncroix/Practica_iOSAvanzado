//
//  MockSegureDataUserDefault.swift
//  DragonBallAPPTests
//
//  Created by Jose Bueno Cruz on 4/3/24.
//

import Foundation
@testable import DragonBallAPP

struct MockSegureDataUserDefault: SecureDataKeychainProtocol {
    
    let userDefaults = UserDefaults.standard
    let keyToken = "keyToken"
    
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
