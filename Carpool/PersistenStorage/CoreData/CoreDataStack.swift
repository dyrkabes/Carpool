//
//  CoreDataStack.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    private let modelName: String
//    private let storeType: CoreDataPersistentStoreType
    
    private lazy var documentDirectory: URL? = {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let storeName = modelName + ".sqlite"
        let storeURL = documentDirectory?.appendingPathComponent(storeName)
        return storeURL
    }()
    
    lazy var context: NSManagedObjectContext = {
        return managedObjectContext
    }()
    
    private lazy var maangedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("NSManagedObjectModel \(self.self) \(#function) could not initialized")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("NSManagedObjectModel \(self.self) \(#function) could not initialized")
        }
        
        return model
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: maangedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: documentDirectory,
                                               options: nil)
        } catch {
            fatalError("\(error)")
        }
        return coordinator
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        context.mergePolicy = NSMergePolicy.overwrite
        return context
    }()
    
    // MARK: - Init
    init(modelName: String) {
        self.modelName = modelName
    }
}
