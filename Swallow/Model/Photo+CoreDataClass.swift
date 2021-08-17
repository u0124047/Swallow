//
//  Photo+CoreDataClass.swift
//  
//
//  Created by Kathy on 2021/8/17.
//
//

import Foundation
import CoreData
import CoreStore

@objc(Photo)
public class Photo: NSManagedObject {
    class func createInitialData(journey_id: UUID, datas: [UIImage]) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: "Photo",
                                       in: managedContext)!

        datas.forEach { data in
            if let imgData = data.jpegData(compressionQuality: 1) {
                createData(journey_id: journey_id, data: imgData)
            }
        }

        func createData(journey_id: UUID, data: Data) {
            let photo = NSManagedObject(entity: entity,
                                         insertInto: managedContext)

            photo.setValue(UUID(), forKeyPath: "id")
            photo.setValue(data, forKeyPath: "data")
            photo.setValue(Date(), forKeyPath: "create_time")
            photo.setValue(journey_id, forKeyPath: "journey_id")

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }

    class func getAllPhotos(journeyId: UUID) -> [Photo] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Photo")

        fetchRequest.predicate = NSPredicate(format: "journey_id == %@", journeyId as CVarArg)

        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [Photo] ?? []
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
}
