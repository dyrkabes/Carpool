//
//  InMemoryStorage.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

/// Stores placemarks in memory.
struct InMemoryStorage: PersistentStorageWorker {
    // MARK: - Instance properties
    fileprivate var placemarks: [Placemark] = []
    
    // MARK: - Public func
    func getPlacemarks() -> [Placemark] {
        return placemarks
    }
    
    mutating func writePlacemarks(_ placemarks: [Placemark]) throws {
        self.placemarks = placemarks
    }
}
