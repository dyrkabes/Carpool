//
//  StorageTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
@testable import Carpool

class StorageTests: XCTestCase {
    func testInMemoryStorage() {
        var inMemoryStorage = InMemoryStorage()
        inMemoryStorage.writePlacemarks([])
        
        XCTAssertEqual(inMemoryStorage.getPlacemarks().count, 0)
        
        inMemoryStorage.writePlacemarks([Placemark.empty])
        XCTAssertEqual(inMemoryStorage.getPlacemarks().count, 1)
    }
}
