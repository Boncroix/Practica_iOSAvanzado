//
//  EndPoints.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 25/2/24.
//

import Foundation

enum EndPoints {
    case login
    case heroes
    case transformations
    case locations
    
    func endpoint() -> String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .heroes:
            return "/api/heros/all"
        case .transformations:
            return "/api/heros/tranformations"
        case .locations:
            return "/api/heros/locations"
        }
    }
}
