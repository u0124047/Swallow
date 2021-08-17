//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Kathy on 2021/8/17.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var data: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var create_time: Date?
    @NSManaged public var journey_id: UUID?

}
