//
//  CoreDataManager.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let storageName = "books"
    
    func saveContextChanges() {
        guard managedObjectContext.hasChanges || savingManagedObjectContext.hasChanges else {
            return
        }
        
        managedObjectContext.performBlockAndWait() {
            do {
                try self.managedObjectContext.save()
            } catch {
                fatalError("Managed object context error: \(error)")
            }
        }
        savingManagedObjectContext.performBlock() {
            do {
                try self.savingManagedObjectContext.save()
            } catch {
                fatalError("Managed object context error: \(error)")
            }
        }
    }
    
    // MARK: - Instantiation
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(storageName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(storageName).sqlite")

        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            fatalError("Persistent store error: \(error)")
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.parentContext = self.savingManagedObjectContext
        return managedObjectContext
    }()
    
    private lazy var savingManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
}
