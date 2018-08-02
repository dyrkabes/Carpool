//
//  PersistentStorgateWorkerStub.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool

final class PersistentStorageWorkerStub: PersistentStorageWorker {
    var placemarks: [Placemark] = []
    var writesCount = 0
    
    func getPlacemarks() -> [Placemark] {
        return placemarks
    }
    
    func writePlacemarks(_ placemarks: [Placemark]) {
        writesCount += 1
        self.placemarks = placemarks
    }
}
