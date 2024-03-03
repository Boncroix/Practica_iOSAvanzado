//
//  DetailTransformationsViewModel.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 2/3/24.
//

import Foundation

final class DetailTransformationsViewModel {
    
    //MARK: - Bindind con UI
    var detailViewState: ((DetailTransformationsStatusLoad) -> Void)?
    
    var transformation: NSMTransformations
    
    //MARK: Inits
    init(transformation: NSMTransformations) {
        self.transformation = transformation
    }
}
