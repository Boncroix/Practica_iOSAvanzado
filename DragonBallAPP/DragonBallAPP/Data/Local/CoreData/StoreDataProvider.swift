//
//  StoreDataProvider.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//

import Foundation
import CoreData

final class StoreDataProvider {
    
    let persistenContainer: NSPersistentContainer
    var context: NSManagedObjectContext {
        return persistenContainer.viewContext
    }
    
    init() {
        self.persistenContainer = NSPersistentContainer(name: "Model")
        self.persistenContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Error creating BBDD")
            }
        }
    }
}

extension StoreDataProvider {
    
    func insert(heros: [Hero]) {
        context.performAndWait {
            for hero in heros {
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
    
    func fetchHeros(filter: NSPredicate? = nil) -> [NSMHero] {
        let request = NSMHero.fetchRequest()
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
                newTransformation.hero = self.fetchHeros(filter: filter).first
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
