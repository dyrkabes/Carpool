//
//  PersistentStorageWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

protocol PersistentStorageWorker {
    func getPlacemarks() -> [Placemark]
    mutating func writePlacemarks(_ placemarks: [Placemark]) throws
}
