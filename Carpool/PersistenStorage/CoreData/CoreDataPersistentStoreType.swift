//
//  CoreDataPersistentStoreType.swift
//  Carpool
//
//  Created by Pavel Stepanov on 30/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CoreData

enum CoreDataPersistentStoreType {
    case SQLite
    case inMemory
    
    var value: String {
        switch self {
        case .SQLite:
            return NSSQLiteStoreType
        case .inMemory:
            return NSInMemoryStoreType
        }
    }
    
    func getUrl(modelName: String) -> URL? {
        switch self {
        case .inMemory:
            return nil
        case .SQLite:
            let documentDirectory = FileManager.documentDirectory
            let storeName = modelName + ".sqlite"
            let storeURL = documentDirectory?.appendingPathComponent(storeName)
            return storeURL
        }
    }
}
