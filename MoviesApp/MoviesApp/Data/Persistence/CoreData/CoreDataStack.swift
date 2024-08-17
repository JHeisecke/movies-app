//
//  CoreDataStack.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-16.
//

import Foundation
import CoreData

enum CoreDataModel: String {
    case watchlist = "MovieModel"
}

class CoreDataStack {
    private let modelName: String

    init(_ model: CoreDataModel) {
        self.modelName = model.rawValue
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var context: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext() throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            throw error
        }
    }
    
    func deleteAllEntities() {
        let entities = storeContainer.managedObjectModel.entities
        for entity in entities {
            delete(entityName: entity.name!)
        }
    }

    func delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try storeContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
