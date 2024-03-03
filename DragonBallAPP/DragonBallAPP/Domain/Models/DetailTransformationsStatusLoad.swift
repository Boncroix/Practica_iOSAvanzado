//
//  DetailTransformationsStatusLoad.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 2/3/24.
//

import Foundation

enum DetailTransformationsStatusLoad {
    case loading(_ isLoading: Bool)
    case loaded
    case errorNetwork(_error: String)
}
