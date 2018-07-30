//
//  InMemoryStorageTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
@testable import Carpool

class InMemoryStorageTests: XCTestCase {
    func testWriteEmptyArray() {
        // Given
        var inMemoryStorage = InMemoryStorage()
        
        // When
        inMemoryStorage.writePlacemarks([])
        
        // Then
        XCTAssertEqual(inMemoryStorage.getPlacemarks().count, 0)
    }
    
    func testWriteOneElement() {
        // Given
        var inMemoryStorage = InMemoryStorage()
        
        // When
        inMemoryStorage.writePlacemarks([Placemark.empty])
        
        // Then
        XCTAssertEqual(inMemoryStorage.getPlacemarks().count, 1)
    }
}
