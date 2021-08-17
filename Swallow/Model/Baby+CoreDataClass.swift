//
//  Baby+CoreDataClass.swift
//  Swallow
//
//  Created by Kathy on 2021/8/16.
//
//

import Foundation
import CoreData
import SwiftyJSON
import CoreStore

@objc(Baby)
public class Baby: NSManagedObject {

}

extension Baby {
    class func createInitialData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: "Baby",
                                       in: managedContext)!

        let baby = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        baby.setValue(UUID(), forKeyPath: "id")
        baby.setValue("Swallow", forKeyPath: "name")
        baby.setValue(1, forKeyPath: "gender")
        baby.setValue("2021/05/22".convertToDate(), forKeyPath: "birth")
        baby.setValue("Kathy", forKeyPath: "mom")
        baby.setValue("Sam", forKeyPath: "dad")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    class func getAllBabys() -> [Baby] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Baby")

        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [Baby] ?? []
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
}
