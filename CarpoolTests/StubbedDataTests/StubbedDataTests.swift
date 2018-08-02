//
//  StubbedDataTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
@testable import Carpool

final class StubbedDataTests: XCTestCase {
    func testStubbedData() {
        // Given
        let locations = StubDataProvider.locations
        
        // Then
        XCTAssertEqual(locations.fileName, "locations")
        XCTAssertNotNil(locations.data)
    }
}

