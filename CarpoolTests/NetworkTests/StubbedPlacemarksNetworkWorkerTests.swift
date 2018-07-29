//
//  LocalPlacemarksNetworkWorkerTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 27/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
@testable import Carpool

class LocalPlacemarksNetworkWorkerTests: XCTestCase {
    var localPlacemarkNetworkWorker: LocalPlacemarksNetworkWorker!
    
    override func tearDown() {
        localPlacemarkNetworkWorker = nil
        super.tearDown()
    }
    
    func testLoadPlacemarks() {
        localPlacemarkNetworkWorker = LocalPlacemarksNetworkWorker(placemarksData: StubDataProvider.locations.data)
        
        var placemarks: [Placemark] = []
        var fetchedError: Error?
        
        let expectation = self.expectation(description: "NetworkResponse")
        
        localPlacemarkNetworkWorker.loadPlacemarks(success: { (receivedPlacemarks) in
            placemarks = receivedPlacemarks
            expectation.fulfill()
        }) { (error) in
            fetchedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.5, handler: nil)
        
        XCTAssertEqual(placemarks.count, 423)
        XCTAssertNil(fetchedError)
    }
    
    func testLoadTreasurePlacemarks() {
        localPlacemarkNetworkWorker = LocalPlacemarksNetworkWorker(placemarksData: Data())
        
        var placemarks: [Placemark] = []
        var fetchedError: Error?
        
        let expectation = self.expectation(description: "NetworkResponse")
        
        localPlacemarkNetworkWorker.loadPlacemarks(success: { (receivedPlacemarks) in
            placemarks = receivedPlacemarks
            expectation.fulfill()
        }) { (error) in
            fetchedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.5, handler: nil)
        
        XCTAssertEqual(placemarks.count, 0)
        
        let networkError = fetchedError as? NetworkError
        
        XCTAssertNotNil(networkError)
        XCTAssertEqual(networkError, NetworkError.parsingFailure)
    }
    
    func testLoadNoData() {
        localPlacemarkNetworkWorker = LocalPlacemarksNetworkWorker(placemarksData: nil)
        
        var placemarks: [Placemark] = []
        var fetchedError: Error?
        
        let expectation = self.expectation(description: "NetworkResponse")
        
        localPlacemarkNetworkWorker.loadPlacemarks(success: { (receivedPlacemarks) in
            placemarks = receivedPlacemarks
            expectation.fulfill()
        }) { (error) in
            fetchedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.5, handler: nil)
        
        XCTAssertEqual(placemarks.count, 0)
        
        let networkError = fetchedError as? NetworkError
        
        XCTAssertNotNil(networkError)
        XCTAssertEqual(networkError, NetworkError.unknown)
    }
}
