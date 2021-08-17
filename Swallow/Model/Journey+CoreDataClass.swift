//
//  Journey+CoreDataClass.swift
//  
//
//  Created by Kathy on 2021/8/16.
//
//

import Foundation
import CoreData
import CoreStore
import SwiftyJSON

@objc(Journey)
public class Journey: NSManagedObject {

    public convenience init?(_: Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "Journey", in: managedContext) else {
            return nil
        }
        self.init(entity: entity, insertInto: nil)
    }

    class func create(journey: Journey) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: "Journey",
                                       in: managedContext)!

        let journeyObj = NSManagedObject(entity: entity,
                                                insertInto: managedContext)

        journeyObj.setValue(journey.id, forKeyPath: "id")
        journeyObj.setValue(journey.journeyType, forKeyPath: "journeyType")
        journeyObj.setValue(journey.title, forKeyPath: "title")
        journeyObj.setValue(journey.content, forKeyPath: "content")
        journeyObj.setValue(journey.date, forKeyPath: "date")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    class func getAllJourneys() -> [Journey] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Journey")

        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [Journey] ?? []
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }

    class func getAllJourneys(where date: Date) -> [Journey] {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Journey")

        let dayStart = Calendar.current.startOfDay(for: date)
        let dayEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            // swiftlint:disable:next force_unwrapping
            return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: date))!
        }()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", dayStart as CVarArg, dayEnd as CVarArg)

        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [Journey] ?? []
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
}
