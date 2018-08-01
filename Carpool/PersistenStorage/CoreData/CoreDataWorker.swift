//
//  CoreDataWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CoreData

final class CoreDataWorker: PersistentStorageWorker {
    // MARK: - Instance properties
    private let modelName: String
    private let storeType: CoreDataPersistentStoreType
    
    // MARK: - Injected
    private lazy var stack: CoreDataStack = {
        return CoreDataStack(modelName: modelName, storeType: storeType)
    }()
    
    // MARK: - Init
    init(modelName: String, storeType: CoreDataPersistentStoreType) {
        self.modelName = modelName
        self.storeType = storeType
    }
    
    // MARK: - Public func
    func getPlacemarks() -> [Placemark] {
        guard let placemarksManaged: [PlacemarkManaged] = fetch() else {
            return []
        }
        
        return placemarksManaged.compactMap { Placemark(managedObject: $0) }
    }
    
    func writePlacemarks(_ placemarks: [Placemark]) {
        placemarks.forEach { placemark in
            let placemarkManaged = PlacemarkManaged(context: self.stack.context)
            placemarkManaged.populate(with: placemark)
        }
        
        do {
            try saveChanges()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Storage functions
    private func delete(_ object: NSManagedObject) {
        stack.context.delete(object)
    }
    
    private func saveChanges() throws {
        guard stack.context.hasChanges else { return }
        
        do {
            try stack.context.save()
        } catch {
            throw error
        }
    }
    
    private func fetch<T: NSFetchRequestResult>() -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        do {
            let result: [T] = try stack.context.fetch(fetchRequest)
            return result
        } catch {
            print(error)
            return nil
        }
    }
}
