//
//  BaseMapInteractorTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
@testable import Carpool

class BaseMapInteractorTests: XCTestCase {
    var baseMapViewInteractor: BaseMapViewInteractor!
    private var mainInteractorFake: MainInteractorFake!
    
    var successCount = 0
    var failureCount = 0
    
    var fetchedPlacemarks: [Placemark] = []
    var fetchedError: Error?
    
    override func tearDown() {
        baseMapViewInteractor = nil
        mainInteractorFake = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        mainInteractorFake = MainInteractorFake(isSuccess: true)
        baseMapViewInteractor = BaseMapViewInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseMapViewInteractor.getData(success: { (placemarks) in
            self.successCount += 1
            self.fetchedPlacemarks = placemarks
        }, failure: { error in
            self.failureCount += 1
            self.fetchedError = error
        })
        
        // Then
        XCTAssertEqual(successCount, 1)
        XCTAssertEqual(failureCount, 0)
        XCTAssertEqual(mainInteractorFake.getDataCount, 1)
        XCTAssertEqual(mainInteractorFake.loadDataCount, 0)
        XCTAssertEqual(fetchedPlacemarks.count, 1)
        XCTAssertNil(fetchedError)
    }
    
    func testLoadData() {
        // Given
        mainInteractorFake = MainInteractorFake(isSuccess: true)
        baseMapViewInteractor = BaseMapViewInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseMapViewInteractor.loadDataFromNetwork(success: { (placemarks) in
            self.successCount += 1
            self.fetchedPlacemarks = placemarks
        }, failure: { error in
            self.failureCount += 1
            self.fetchedError = error
        })
        
        // Then
        XCTAssertEqual(successCount, 1)
        XCTAssertEqual(failureCount, 0)
        XCTAssertEqual(mainInteractorFake.getDataCount, 0)
        XCTAssertEqual(mainInteractorFake.loadDataCount, 1)
        XCTAssertEqual(fetchedPlacemarks.count, 1)
        XCTAssertNil(fetchedError)
    }
    
    func testFailGetData() {
        // Given
        mainInteractorFake = MainInteractorFake(isSuccess: false)
        baseMapViewInteractor = BaseMapViewInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseMapViewInteractor.getData(success: { (placemarks) in
            self.successCount += 1
            self.fetchedPlacemarks = placemarks
        }, failure: { error in
            self.failureCount += 1
            self.fetchedError = error
        })
        
        // Then
        XCTAssertEqual(successCount, 0)
        XCTAssertEqual(failureCount, 1)
        XCTAssertEqual(mainInteractorFake.getDataCount, 1)
        XCTAssertEqual(mainInteractorFake.loadDataCount, 0)
        XCTAssertEqual(fetchedPlacemarks.count, 0)
        XCTAssertEqual(fetchedError as? NetworkError, NetworkError.unknown)
    }
    
    func testFailLoadData() {
        // Given
        mainInteractorFake = MainInteractorFake(isSuccess: false)
        baseMapViewInteractor = BaseMapViewInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseMapViewInteractor.loadDataFromNetwork(success: { (placemarks) in
            self.successCount += 1
            self.fetchedPlacemarks = placemarks
        }, failure: { error in
            self.failureCount += 1
            self.fetchedError = error
        })
        
        // Then
        XCTAssertEqual(successCount, 0)
        XCTAssertEqual(failureCount, 1)
        XCTAssertEqual(mainInteractorFake.getDataCount, 0)
        XCTAssertEqual(mainInteractorFake.loadDataCount, 1)
        XCTAssertEqual(fetchedPlacemarks.count, 0)
        XCTAssertEqual(fetchedError as? NetworkError, NetworkError.unknown)
    }
}
