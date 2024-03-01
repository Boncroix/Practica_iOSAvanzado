//
//  DetailViewModel.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 1/3/24.
//

import Foundation


final class DetailViewModel {
    
    //MARK: - Binding con UI
    var detailViewState: ((DetailStatusLoad) -> Void)?
    
    //MARK: - Binding con Api
    private var apiProvider: ApiProvider
    private var storeDataProvider: StoreDataProvider
    var transformations: [NSMTransformations] = []
    var hero: NSMHero
    
    //MARK: - Inits
    init(apiProvider: ApiProvider = ApiProvider(),
         storeDataProvider: StoreDataProvider = StoreDataProvider(),
         hero: NSMHero) {
        self.apiProvider = apiProvider
        self.storeDataProvider = storeDataProvider
        self.hero = hero
    }
    
    //MARK: Load Data
    func loadData() {
        transformations = storeDataProvider.fetchTransformations(
            sorting: self.sortDescriptor(ascending: true))
        if transformations.isEmpty {
            self.getTransformations(idHero: hero.id)
        } else {
            notifyDataUpdated()
        }
    }
    
    func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.detailViewState?(.loaded)
        }
    }
    
    private func sortDescriptor(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMTransformations.name, ascending: ascending)
        return [sort]
    }
    
    func loadDataFromServices(id: String) {
        let queueLoadData = DispatchQueue(label: "loadData")
        
        let group = DispatchGroup()
        
        group.enter()
        queueLoadData.async {
            self.getTransformations(idHero: id)
        }
        
        group.enter()
        queueLoadData.async {
            self.getLocation(idHero: id)
        }
        
        group.notify(queue: .main) {
            self.notifyDataUpdated()
        }
    }
    
    //MARK: - GetHeroesApi
    private func getTransformations(idHero: String) {
        apiProvider.getTransformationsForHeroWith(id: idHero) { [weak self] result in
            switch result {
            case .success(let transformations):
                self?.storeDataProvider.insert(transformations: transformations)
            case .failure(let error):
                print("Error loading transformations \(error.description)")
            }
        }
    }
    
    private func getLocation(idHero: String) {
        apiProvider.getLocationsForHeroWith(id: idHero) { [weak self] result in
            switch result {
            case .success(let locations):
                self?.storeDataProvider.insert(locations: locations)
            case .failure(let error):
                print("Error loading location \(error.description)")
            }
        }
    }
}
