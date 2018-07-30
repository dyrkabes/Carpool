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

// TODO: Adopt "Given When Then"
class AppMainInteractorTests: XCTestCase {
    var appMainInteractor: AppMainInteractor!
    private var placemarksNetworkerFake: PlacemarksNetworkWorkerFake!
    private var persistentStorageWorkerFake: PersistentStorageWorkerFake!
    
    override func setUp() {
        super.setUp()
        
        placemarksNetworkerFake = PlacemarksNetworkWorkerFake()
        persistentStorageWorkerFake = PersistentStorageWorkerFake()
        
        appMainInteractor = AppMainInteractor(networkWorker: placemarksNetworkerFake, storageWorker: persistentStorageWorkerFake)
    }
    
    override func tearDown() {
        appMainInteractor = nil
        placemarksNetworkerFake = nil
        persistentStorageWorkerFake = nil
        super.tearDown()
    }
    
    func testLoadData() {
        let expectation = self.expectation(description: "NetworkResponse")
        
        appMainInteractor.loadDataFromNetwork(success: { (receivedPlacemarks) in
            expectation.fulfill()
        }) { (error) in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(placemarksNetworkerFake.loadPlacemarksCallsCount, 1)
        XCTAssertEqual(persistentStorageWorkerFake.writesCount, 1)
        XCTAssertEqual(persistentStorageWorkerFake.placemarks.count, 1)
    }
    
    func testGetData() {
        let expectation1 = self.expectation(description: "FirstNetworkResponse")
        placemarksNetworkerFake.shouldSucceed = true
        
        var fetchedError: Error?
        
        appMainInteractor.getData(success: { _ in
            expectation1.fulfill()
        }) { (error) in
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(placemarksNetworkerFake.loadPlacemarksCallsCount, 1)
        
        let expectation2 = self.expectation(description: "SecondNetworkResponse")
        appMainInteractor.getData(success: { _ in
            expectation2.fulfill()
        }) { (error) in
            fetchedError = error
            expectation2.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(placemarksNetworkerFake.loadPlacemarksCallsCount, 1)
        XCTAssertNil(fetchedError)
    }
    
    func testGetError() {
        let expectation1 = self.expectation(description: "ErrorNetworkResponse")
        placemarksNetworkerFake.shouldSucceed = false
        
        var fetchedError: Error?
        
        appMainInteractor.getData(success: { (_) in
            expectation1.fulfill()
        }) { (error) in
            fetchedError = error
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertEqual(placemarksNetworkerFake.loadPlacemarksCallsCount, 1)
        XCTAssertEqual(persistentStorageWorkerFake.placemarks.count, 0)
        XCTAssertEqual(persistentStorageWorkerFake.writesCount, 0)
        XCTAssertNotNil(fetchedError)
        XCTAssertEqual(fetchedError as? NetworkError, NetworkError.unknown)
    }
    
    func testMultipleGetData() {
        let expectation1 = self.expectation(description: "FirstNetworkResponse")
        let expectation2 = self.expectation(description: "FirstNetworkResponse")
        let expectation3 = self.expectation(description: "FirstNetworkResponse")
        
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
        
        XCTAssertEqual(placemarksNetworkerFake.loadPlacemarksCallsCount, 1)
        XCTAssertEqual(persistentStorageWorkerFake.placemarks.count, 1)
        XCTAssertEqual(persistentStorageWorkerFake.writesCount, 1)
    }
}

private class PlacemarksNetworkWorkerFake: PlacemarksNetworkWorker {
    var loadPlacemarksCallsCount = 0
    var shouldSucceed: Bool = true
    
    func loadPlacemarks(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        loadPlacemarksCallsCount += 1
        if shouldSucceed {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                success([Placemark.empty])
            }
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                failure(NetworkError.unknown)
            }
        }
    }
}

private class PersistentStorageWorkerFake: PersistentStorageWorker {
    var placemarks: [Placemark] = []
    var writesCount = 0
    
    func getPlacemarks() -> [Placemark] {
        return placemarks
    }
    
    func writePlacemarks(_ placemarks: [Placemark]) {
        writesCount += 1
        self.placemarks = placemarks
    }
}
