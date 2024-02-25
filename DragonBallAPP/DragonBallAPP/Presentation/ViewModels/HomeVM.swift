//
//  HomeVM.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 25/2/24.
//

import Foundation

final class HomeVM {
    
    private var secureData: SecureDataKeychainProtocol
    
    init(secureData: SecureDataKeychainProtocol = SecureDataKeychain()) {
        self.secureData = secureData
    }
    
    func deleteToken() {
        secureData.deleteToken()
    }
}
