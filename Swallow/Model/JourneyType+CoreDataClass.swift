//
//  JourneyType+CoreDataClass.swift
//  
//
//  Created by Kathy on 2021/8/16.
//
//

import Foundation
import CoreData
import SwiftyJSON
import CoreStore


@objc(JourneyType)
public class JourneyType: NSManagedObject {
    private static var privateJourneyType: [JourneyType]?

    static var shared: [JourneyType]? {
        var shared: [JourneyType]?
        if shared != nil {
            shared = privateJourneyType
        } else {
            shared = JourneyType.getAllJourneyTypes()
        }
        return shared
    }

    func journeyTypeValue(of key: String) -> String {
        return JourneyType.shared?.filter({$0.key == key}).first?.value ?? ""
    }

    deinit {
        print("JourneyType.deinit...")
    }
}

extension JourneyType {
    class func createInitialData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "JourneyType",
                                       in: managedContext)!
        
        let journeyTypeDoctor = NSManagedObject(entity: entity,
                                                insertInto: managedContext)
        
        journeyTypeDoctor.setValue(UUID(), forKeyPath: "id")
        journeyTypeDoctor.setValue("doctor", forKeyPath: "key")
        journeyTypeDoctor.setValue("看診", forKeyPath: "value")
        
        let journeyTypeGrandma = NSManagedObject(entity: entity,
                                                 insertInto: managedContext)
        
        journeyTypeGrandma.setValue(UUID(), forKeyPath: "id")
        journeyTypeGrandma.setValue("grandma", forKeyPath: "key")
        journeyTypeGrandma.setValue("外婆家", forKeyPath: "value")
        
        let journeyTypeShopping = NSManagedObject(entity: entity,
                                                  insertInto: managedContext)
        
        journeyTypeShopping.setValue(UUID(), forKeyPath: "id")
        journeyTypeShopping.setValue("shopping", forKeyPath: "key")
        journeyTypeShopping.setValue("購物", forKeyPath: "value")
        
        let journeyTypeRestaurant = NSManagedObject(entity: entity,
                                                    insertInto: managedContext)
        
        journeyTypeRestaurant.setValue(UUID(), forKeyPath: "id")
        journeyTypeRestaurant.setValue("restaurant", forKeyPath: "key")
        journeyTypeRestaurant.setValue("吃飯", forKeyPath: "value")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    class func getAllJourneyTypes() -> [JourneyType] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "JourneyType")

        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [JourneyType] ?? []
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
}
