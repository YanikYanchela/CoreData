//
//  CoreDataManager.swift
//  CoreDataCars
//
//  Created by Дмитрий Яновский on 8.04.24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    } ()
    // Описание сущности
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    func fetchResultController(entityName: String, sortName: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        //запрос на получение
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        //сортировка
        let sortDescriptor = NSSortDescriptor(key: sortName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // создание контроллера
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataCars")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
