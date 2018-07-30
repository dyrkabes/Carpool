//
//  HelpersTests.swift
//  CPCommonTests
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
@testable import CPCommon

final class HelperTests: XCTestCase {
    func testFileDataLoader() {
        // Given
        let dataLoader = FileDataLoader()
        let bundle = Bundle(for: type(of: self))
        
        // Then
        XCTAssertNotNil(dataLoader.loadFromJSONFile("locations", bundle: bundle))
        XCTAssertNil(dataLoader.loadFromJSONFile("whatIsLifeAnswer", bundle: bundle))
    }
}
