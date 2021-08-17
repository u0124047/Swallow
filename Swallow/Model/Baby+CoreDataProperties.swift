//
//  Baby+CoreDataProperties.swift
//  Swallow
//
//  Created by Kathy on 2021/8/16.
//
//

import Foundation
import CoreData


extension Baby {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Baby> {
        return NSFetchRequest<Baby>(entityName: "Baby")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var gender: Int32
    @NSManaged public var birth: Date?
    @NSManaged public var mom: String?
    @NSManaged public var dad: String?

}
