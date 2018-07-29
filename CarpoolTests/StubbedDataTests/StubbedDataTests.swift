//
//  StubbedDataTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
@testable import Carpool

class StubbedDataTests: XCTestCase {
    func testStubbedData() {
        let locations = StubDataProvider.locations
        
        XCTAssertEqual(locations.fileName, "locations")
        XCTAssertNotNil(locations.data)
    }
}

