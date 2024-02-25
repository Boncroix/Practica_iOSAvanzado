//
//  LoginStatusLoad.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 24/2/24.
//

import Foundation

enum LoginStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case showErrorEmail(_ error: String?)
    case showErrorPassword(_ error: String?)
    case errorNetwork(_error: String)
}
