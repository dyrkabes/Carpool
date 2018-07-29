//
//  CoreDataPersistentStorageWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

struct CoreDataPersistentStorageWorker: PersistentStorageWorker {
    func getPlacemarks() -> [Placemark] {
        return []
    }
    
    func writePlacemarks(_ placemarks: [Placemark]) {
        print("Written")
    }
}
