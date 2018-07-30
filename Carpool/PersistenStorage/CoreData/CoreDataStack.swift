//
//  CoreDataStack.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation
import CoreData
import CPCommon

final class CoreDataStack {
    private let modelName: String
    private let storeType: CoreDataPersistentStoreType
    
    private lazy var documentDirectory: URL? = {
        return storeType.getUrl(modelName: modelName)
    }()
    
    lazy var context: NSManagedObjectContext = {
        return managedObjectContext
    }()
    
    private lazy var mangedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("NSManagedObjectModel \(self.self) \(#function) could not initialized")
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("NSManagedObjectModel \(self.self) \(#function) could not initialized")
        }
        
        return model
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mangedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: storeType.value,
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
    init(modelName: String, storeType: CoreDataPersistentStoreType) {
        self.modelName = modelName
        self.storeType = storeType
    }
}
