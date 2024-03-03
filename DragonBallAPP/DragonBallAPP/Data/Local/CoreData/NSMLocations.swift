//
//  NSMLocations+CoreDataClass.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 2/3/24.
//
//

import Foundation
import CoreData

@objc(NSMLocations)
public class NSMLocations: NSManagedObject {

}

extension NSMLocations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMLocations> {
        return NSFetchRequest<NSMLocations>(entityName: "Locations")
    }

    @NSManaged public var id: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var date: String?
    @NSManaged public var hero: NSMHero?

}

extension NSMLocations : Identifiable {

}
