//
//  Journey+CoreDataProperties.swift
//  
//
//  Created by Kathy on 2021/8/16.
//
//

import Foundation
import CoreData


extension Journey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journey> {
        return NSFetchRequest<Journey>(entityName: "Journey")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var journeyType: String?

}
