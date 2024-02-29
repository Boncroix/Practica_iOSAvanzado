//
//  ModelTransformation.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//

import Foundation

// MARK: - ModelTransformation
struct Transformation: Decodable {
    let photo: String?
    let hero: Hero?
    let id, name, description: String?
}
