//
//  CoreDataTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 30/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
@testable import Carpool

final class CoreDataTests: XCTestCase {
    var coreDataWorker: CoreDataWorker!
    
    override func setUp() {
        super.setUp()
        coreDataWorker = CoreDataWorker(modelName: CPConstants.modelName, storeType: .inMemory)
    }
    
    override func tearDown() {
        coreDataWorker = nil
        super.tearDown()
    }
    
    func testWritePlacemark() {
        // Given
        XCTAssertEqual(coreDataWorker.getPlacemarks().count, 0)
        
        // When
        coreDataWorker.writePlacemarks([Placemark.empty])
        
        // Then
        XCTAssertEqual(coreDataWorker.getPlacemarks().count, 1)
    }
}
