//
//  DetailStatusLoad.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 1/3/24.
//

import Foundation

enum DetailStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case errorNetwork(_error: String)
}
