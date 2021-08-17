//
//  JourneyType+CoreDataProperties.swift
//  
//
//  Created by Kathy on 2021/8/16.
//
//

import Foundation
import CoreData


extension JourneyType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JourneyType> {
        return NSFetchRequest<JourneyType>(entityName: "JourneyType")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var key: String?
    @NSManaged public var value: String?

}
