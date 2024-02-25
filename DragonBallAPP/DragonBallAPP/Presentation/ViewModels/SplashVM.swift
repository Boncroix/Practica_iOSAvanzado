//
//  SplashVM.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 24/2/24.
//

import Foundation

final class SplashVM {
    
    var modelStatusLoad: ((SplashStatusLoad) -> Void)?
    
    func simulationLoadData() {
        modelStatusLoad?(.loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.modelStatusLoad?(.loaded)
        }
    }
}
