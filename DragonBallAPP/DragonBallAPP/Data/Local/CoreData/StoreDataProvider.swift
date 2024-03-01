//
//  StoreDataProvider.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//

import Foundation
import CoreData

enum StoreType {
    case disk
    case inMemory
}

final class StoreDataProvider {
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: StoreDataProvider.self)
        guard  let url = bundle.url(forResource: "Model", withExtension: "momd"),
               let mom = NSManagedObjectModel(contentsOf: url) else {
            fatalError(" Error loading model file")
        }
        return mom
    }()
    
    static var shared = StoreDataProvider()
    
    let persistentContainer: NSPersistentContainer
    lazy var context: NSManagedObjectContext = {
        var viewContext = persistentContainer.viewContext
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return viewContext
    }()
    
    init(storeType: StoreType = .disk) {
        self.persistentContainer = NSPersistentContainer(name: "Model", managedObjectModel: Self.managedObjectModel)
        if  storeType == .inMemory {
            if let store = self.persistentContainer.persistentStoreDescriptions.first {
                store.url = URL(filePath: "dev/null")
            } else {
                fatalError(" Error loading persistent Store Description")
            }
        }
        self.persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error creating BBDD \(error)")
            }
        }
    }
}

extension StoreDataProvider {
    
    func insert(heroes: [Hero]) {
        context.performAndWait {
            for hero in heroes {
                let newHero = NSMHero(context: context)
                newHero.id = hero.id
                newHero.name = hero.name
                newHero.photo = hero.photo
                newHero.favorite = hero.favorite ?? false
                newHero.descrip = hero.description
            }
            self.saveContext()
        }
    }
    
    func fetchHeroes(filter: NSPredicate? = nil,
                     sorting: [NSSortDescriptor]? = nil) -> [NSMHero] {
        
        let request = NSMHero.fetchRequest()
        request.predicate = filter
        request.sortDescriptors = sorting
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func insert(transformations: [Transformation]) {
        context.performAndWait {
            for transformation in transformations {
                let newTransformation = NSMTransformations(context: context)
                newTransformation.id = transformation.id
                newTransformation.name = transformation.name
                newTransformation.photo = transformation.photo
                newTransformation.descrip = transformation.description
                let filter = NSPredicate(format: "id == %@", transformation.hero?.id ?? "")
                newTransformation.hero = self.fetchHeroes(filter: filter).first
            }
            self.saveContext()
        }
    }
    
    func fetcTransformations() -> [NSMTransformations] {
        let request = NSMTransformations.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func clearBBDD() {
        let deleteHeroes = NSBatchDeleteRequest(fetchRequest: NSMHero.fetchRequest())
        let deleteTransformations = NSBatchDeleteRequest(fetchRequest: NSMTransformations.fetchRequest())
        context.reset()
        
        for task in [deleteHeroes, deleteTransformations] {
            do {
               try  context.execute(task)
            } catch {
                debugPrint("Error cleaing BBDD")
            }
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                debugPrint("Error saving changes in BBDD")
            }
        }
    }
}
