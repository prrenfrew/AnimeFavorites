//
//  CoreDataManager.swift
//  AnimeFavorites
//
//  Created by MAC on 10/28/20.
//

import Foundation
import CoreData

final class CoreDataManager {
  static let shared = CoreDataManager()
  
  private init() { }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Anime")
    container.loadPersistentStores { (description, error) in
      print(description)
      print(error ??  "No error")
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func getAllObjects<T: NSManagedObject>(objectType: T.Type, predicate: NSPredicate? = nil) -> [T] {
    let fetchRequest = NSFetchRequest<T>(entityName: String(describing: objectType))
    if let predicate = predicate {
      fetchRequest.predicate = predicate
    }
    do {
      let objects = try context.fetch(fetchRequest)
      print(objects)
      return objects
    } catch {
      print(error)
      return []
    }
  }
  
  func createNewObject<T: NSManagedObject>(
    objectType: T.Type,
    shouldInsertIntoContext insert: Bool = true,
    setupClosure: ((T) -> Void)?) -> T? {
    guard let entityDescription =
            NSEntityDescription.entity(
              forEntityName:
                String(describing: objectType),
              in: context) else { return nil }
    let newObject = T(
      entity: entityDescription,
      insertInto: insert ? context : nil)
    setupClosure?(newObject)
    return newObject
  }
  
  @discardableResult
  func insertObject(_ object: NSManagedObject) -> Bool {
    context.insert(object)
    return true
  }
  
  @discardableResult
  func deleteObject(_ object: NSManagedObject) -> Bool {
    context.delete(object)
    return true
  }
}
