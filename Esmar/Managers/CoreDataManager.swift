//
//  CoreDataManager.swift
//  Esmar
//
//  Created by Rafael Nunes on 26/02/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    private init() {
        self.persistentContainer = NSPersistentContainer(name: "BudgetModel")
        self.persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialize Core Data stack \(error)")
            }

        }
    }
}
