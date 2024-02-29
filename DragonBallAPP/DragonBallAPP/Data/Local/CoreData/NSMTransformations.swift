//
//  NSMTransformations+CoreDataClass.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 28/2/24.
//
//

import Foundation
import CoreData

@objc(NSMTransformations)
public class NSMTransformations: NSManagedObject {

}

extension NSMTransformations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMTransformations> {
        return NSFetchRequest<NSMTransformations>(entityName: "Transformations")
    }

    @NSManaged public var photo: String?
    @NSManaged public var heroid: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var descrip: String?
    @NSManaged public var hero: NSMHero?

}

extension NSMTransformations : Identifiable {

}
