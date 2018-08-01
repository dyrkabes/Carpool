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

class BaseCarListInteractorTests: XCTestCase {
    var baseCarListInteractor: BaseCarListInteractor!
    private var mainInteractorFake: MainInteractorFake!
    
    var successCount = 0
    var failureCount = 0
    
    lazy var fetchedPlacemarks: [Placemark] = {
        return baseCarListInteractor.getPlacemarks()
    }()
    var fetchedError: Error?
    
    override func tearDown() {
        baseCarListInteractor = nil
        mainInteractorFake = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        mainInteractorFake = MainInteractorFake(isSuccess: true)
        baseCarListInteractor = BaseCarListInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseCarListInteractor.getData(success: {
            self.successCount += 1
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
        baseCarListInteractor = BaseCarListInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseCarListInteractor.reloadData(success: {
            self.successCount += 1
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
        baseCarListInteractor = BaseCarListInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseCarListInteractor.getData(success: {
            self.successCount += 1
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
        baseCarListInteractor = BaseCarListInteractor(parentInteractor: mainInteractorFake)
        
        // When
        baseCarListInteractor.reloadData(success: {
            self.successCount += 1
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
