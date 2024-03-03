//
//  DetailViewModel.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 1/3/24.
//

import Foundation
import CoreData


final class DetailViewModel {
    
    //MARK: - Binding con UI
    var detailViewState: ((DetailStatusLoad) -> Void)?
    
    //MARK: - Binding con Api
    private var apiProvider: ApiProvider
    private var storeDataProvider: StoreDataProvider
    var transformations: [NSMTransformations] = []
    var locations: [NSMLocations] = []
    var hero: NSMHero
    
    //MARK: - Inits
    init(apiProvider: ApiProvider = ApiProvider(),
         storeDataProvider: StoreDataProvider = StoreDataProvider(),
         hero: NSMHero) {
        self.apiProvider = apiProvider
        self.storeDataProvider = storeDataProvider
        self.hero = hero
        self.addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    //MARK: Load Data
    func loadData() {
        locations = Array(hero.heroToLocations ?? [])
        if locations.isEmpty {
            loadDataFromServices(id: hero.id)
        } else {
            notifyDataUpdated()
        }
    }
    
    func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.detailViewState?(.loaded)
        }
    }
    
    //MARK: - SelectTransformation
    func transformation(indexPath: IndexPath) -> NSMTransformations? {
        guard indexPath.row < transformations.count else {return nil }
        return transformations[indexPath.row]
    }
    
    //MARK: - SortDescriptor
    private func sortDescriptor() {
        transformations = Array(hero.heroToTransformations ?? [])
        transformations.sort {
            let numero1 = Int($0.name?.components(separatedBy: ".").first ?? "") ?? 0
            let numero2 = Int($1.name?.components(separatedBy: ".").first ?? "") ?? 0
            return numero1 < numero2
        }
    }
    
    func loadDataFromServices(id: String) {
        let queueLoadData = DispatchQueue(label: "loadData")
        
        let group = DispatchGroup()
        
        group.enter()
        queueLoadData.async {
            self.getTransformations(idHero: id)
        }
        group.leave()
        
        group.enter()
        queueLoadData.async {
            self.getLocation(idHero: id)
        }
        group.leave()
        
        group.notify(queue: .main) {
            self.notifyDataUpdated()
        }
    }
    
    //MARK: - GetTransformationsApi
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
    
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didSaveObjectsNotification, object: nil, queue: .main) { notification in
                self.locations = Array(self.hero.heroToLocations ?? [])
                self.transformations = Array(self.hero.heroToTransformations ?? [])
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
