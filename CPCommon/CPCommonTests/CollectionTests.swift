//
//  CollectionExtensionTests.swift
//  HandySwift iOS
//
//  Created by Stepanov Pavel on 08/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest

class CollectionExtensionTests: XCTestCase {
    func testTrySubscript() {
        // Given
        let testArray = [0, 1, 2, 3, 20]
        
        // Then
        XCTAssertNil(testArray[try: 8])
        XCTAssert(testArray[try: -1] == nil)
        XCTAssert(testArray[try: 0] != nil)
        XCTAssert(testArray[try: 4] == testArray[4])
    }
    
    func testEmptyArray() {
        // Given
        let secondTestArray = [Int]()
        
        // Then
        XCTAssertNil(secondTestArray[try: 0])
    }
}
