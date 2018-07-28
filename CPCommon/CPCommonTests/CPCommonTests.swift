//
//  CPCommonTests.swift
//  CPCommonTests
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
@testable import CPCommon

class CPCommonTests: XCTestCase {
    func testIdentifiable() {
        XCTAssertEqual(IdentifiableClass.identifier, "IdentifiableClass")
    }
}

private class IdentifiableClass: Identifiable {}
