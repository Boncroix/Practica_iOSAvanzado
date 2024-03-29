//
//  HomeStatusLoad.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//

import Foundation

enum HeroesStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case errorNetwork(_error: String)
}
