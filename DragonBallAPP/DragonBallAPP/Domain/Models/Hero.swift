//
//  HeroModels.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//

import Foundation

// MARK: - Hero
struct Hero: Decodable, Hashable {
    let id: String
    let name: String?
    let photo: String?
    let description: String?
}
