//
//  CoreDataManager.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func saveContextChanges()
    
    var managedObjectModel: NSManagedObjectModel { get }
    var persistentStoreCoordinator: NSPersistentStoreCoordinator { get }
    var managedObjectContext: NSManagedObjectContext { get }
}

class CoreDataManagerProvider {
    static var sharedManager: CoreDataManagerProtocol = CoreDataManager()
}

class CoreDataManager: NSObject, CoreDataManagerProtocol {
    static let storageName = "books"
    
    private override init() {
        super.init()
    }
    
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
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("\(storageName).sqlite")

        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
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
    
    private lazy var applicationDocumentsDirectory: NSURL = {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }()
    
    private lazy var savingManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
}
