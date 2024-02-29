//
//  Location.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 29/2/24.
//

import Foundation

struct Location: Decodable {

    let id: String?
    let latitude: String?
    let longitude: String?
    let date: String?
    let hero: Hero?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case latitude = "latitud"
        case longitude = "longitud"
        case date = "dateShow"
        case hero
    }
}
