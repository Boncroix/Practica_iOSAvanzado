//
//  NSMHero+CoreDataClass.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//
//

import Foundation
import CoreData

@objc(NSMHero)
public class NSMHero: NSManagedObject {

}

extension NSMHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMHero> {
        return NSFetchRequest<NSMHero>(entityName: "Hero")
    }

    @NSManaged public var name: String
    @NSManaged public var id: String
    @NSManaged public var favorite: Bool
    @NSManaged public var photo: String?
    @NSManaged public var descrip: String?
    @NSManaged public var transformations: Set<NSMTransformations>?

}

// MARK: Generated accessors for transformations
extension NSMHero {

    @objc(addTransformationsObject:)
    @NSManaged public func addToTransformations(_ value: NSMTransformations)

    @objc(removeTransformationsObject:)
    @NSManaged public func removeFromTransformations(_ value: NSMTransformations)

    @objc(addTransformations:)
    @NSManaged public func addToTransformations(_ values: Set<NSMTransformations>)

    @objc(removeTransformations:)
    @NSManaged public func removeFromTransformations(_ values: Set<NSMTransformations>)

}

extension NSMHero : Identifiable {

}
