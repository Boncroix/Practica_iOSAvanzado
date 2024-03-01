//
//  HeroModels.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//

import Foundation

// MARK: - Hero
struct Hero: Decodable, Hashable {
    let name, id: String
    let favorite: Bool?
    let photo: String?
    let description: String?
}
