//
//  AppMainInteractorTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
@testable import Carpool

final class AppMainInteractorTests: XCTestCase {
    var appMainInteractor: AppMainInteractor!
    private var placemarksNetworkerStub: PlacemarksNetworkWorkerStub!
    private var persistentStorageWorkerStub: PersistentStorageWorkerStub!
    
    override func setUp() {
        super.setUp()
        
        placemarksNetworkerStub = PlacemarksNetworkWorkerStub()
        persistentStorageWorkerStub = PersistentStorageWorkerStub()
        
        appMainInteractor = AppMainInteractor(networkWorker: placemarksNetworkerStub, storageWorker: persistentStorageWorkerStub)
    }
    
    override func tearDown() {
        appMainInteractor = nil
        placemarksNetworkerStub = nil
        persistentStorageWorkerStub = nil
        super.tearDown()
    }
    
    func testLoadData() {
        // Given
        let expectation = self.expectation(description: "NetworkResponse")
        
        // When
        appMainInteractor.loadDataFromNetwork(success: { (receivedPlacemarks) in
            expectation.fulfill()
        }) { (error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertEqual(placemarksNetworkerStub.loadPlacemarksCallsCount, 1)
        XCTAssertEqual(persistentStorageWorkerStub.writesCount, 1)
        XCTAssertEqual(persistentStorageWorkerStub.placemarks.count, 1)
    }
    
    func testGetData() {
        // Given
        let expectation1 = self.expectation(description: "FirstNetworkResponse")
        placemarksNetworkerStub.shouldSucceed = true
        
        var fetchedError: Error?
        
        // When
        appMainInteractor.getData(success: { _ in
            expectation1.fulfill()
        }) { (error) in
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertEqual(placemarksNetworkerStub.loadPlacemarksCallsCount, 1)
        
        // When
        let expectation2 = self.expectation(description: "SecondNetworkResponse")
        appMainInteractor.getData(success: { _ in
            expectation2.fulfill()
        }) { (error) in
            fetchedError = error
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertEqual(placemarksNetworkerStub.loadPlacemarksCallsCount, 1)
        XCTAssertNil(fetchedError)
    }
    
    func testGetError() {
        // Given
        let expectation1 = self.expectation(description: "ErrorNetworkResponse")
        placemarksNetworkerStub.shouldSucceed = false
        
        var fetchedError: Error?
        
        // When
        appMainInteractor.getData(success: { (_) in
            expectation1.fulfill()
        }) { (error) in
            fetchedError = error
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertEqual(placemarksNetworkerStub.loadPlacemarksCallsCount, 1)
        XCTAssertEqual(persistentStorageWorkerStub.placemarks.count, 0)
        XCTAssertEqual(persistentStorageWorkerStub.writesCount, 0)
        XCTAssertNotNil(fetchedError)
        XCTAssertEqual(fetchedError as? NetworkError, NetworkError.unknown)
    }
    
    func testMultipleGetData() {
        // Given
        let expectation1 = self.expectation(description: "FirstNetworkResponse")
        let expectation2 = self.expectation(description: "FirstNetworkResponse")
        let expectation3 = self.expectation(description: "FirstNetworkResponse")
        
        // When
        appMainInteractor.getData(success: { (receivedPlacemarks) in
            expectation1.fulfill()
        }) { (error) in
            expectation1.fulfill()
        }
        
        appMainInteractor.getData(success: { (receivedPlacemarks) in
            expectation2.fulfill()
        }) { (error) in
            expectation2.fulfill()
        }
        
        appMainInteractor.getData(success: { (receivedPlacemarks) in
            expectation3.fulfill()
        }) { (error) in
            expectation3.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        // Then
        XCTAssertEqual(placemarksNetworkerStub.loadPlacemarksCallsCount, 1)
        XCTAssertEqual(persistentStorageWorkerStub.placemarks.count, 1)
        XCTAssertEqual(persistentStorageWorkerStub.writesCount, 1)
    }
}
