//
//  BaseMapViewPresenterTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
import CoreLocation
@testable import Carpool

/**
 - Note:
 When CLLocationManager is used via protocol test `centerMap(center:isAnimated:)` function.
 */
class BaseMapViewPresenterTests: XCTestCase {
    private var baseMapViewPresenter: BaseMapViewPresenter!
    private var mapViewInteractorStub: MapViewInteractorStub!
    private var mapViewStub: MapViewStub!
    
    override func setUp() {
        super.setUp()
        
        mapViewStub = MapViewStub()
        mapViewInteractorStub = MapViewInteractorStub(isSuccess: true)
        baseMapViewPresenter = BaseMapViewPresenter(view: mapViewStub, interactor: mapViewInteractorStub)
    }
    
    override func tearDown() {
        baseMapViewPresenter = nil
        mapViewStub = nil
        mapViewInteractorStub = nil
        super.tearDown()
    }
    
    func testSuccessfulGetData() {
        // Given
        mapViewInteractorStub.isSuccess = true
        
        // When
        baseMapViewPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(mapViewStub.populateMapCount, 1)
        XCTAssertEqual(mapViewStub.startLoadingCount, 1)
        XCTAssertEqual(mapViewStub.finishLoadingCount, 1)
        XCTAssertEqual(mapViewStub.showErrorCount, 0)
        XCTAssertNil(mapViewStub.showedErrorText)
        
        XCTAssertEqual(mapViewStub.receivedPlacemarksViewModels.count, 1)
        XCTAssertEqual(mapViewStub.receivedPlacemarksViewModels.first?.name, "")
        
        XCTAssertEqual(mapViewInteractorStub.getDataCount, 1)
        XCTAssertEqual(mapViewInteractorStub.loadDataCount, 0)
    }
    
    func testSuccessfulLoadData() {
        // Given
        mapViewInteractorStub.isSuccess = true
        
        // When
        baseMapViewPresenter.reloadData()
        
        // Then
        XCTAssertEqual(mapViewStub.populateMapCount, 1)
        XCTAssertEqual(mapViewStub.startLoadingCount, 1)
        XCTAssertEqual(mapViewStub.finishLoadingCount, 1)
        XCTAssertEqual(mapViewStub.showErrorCount, 0)
        XCTAssertNil(mapViewStub.showedErrorText)
        
        XCTAssertEqual(mapViewStub.receivedPlacemarksViewModels.count, 1)
        XCTAssertEqual(mapViewStub.receivedPlacemarksViewModels.first?.name, "")
        
        XCTAssertEqual(mapViewInteractorStub.getDataCount, 0)
        XCTAssertEqual(mapViewInteractorStub.loadDataCount, 1)
    }
    
    func testFailureGetData() {
        // Given
        mapViewInteractorStub.isSuccess = false
        
        // When
        baseMapViewPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(mapViewStub.populateMapCount, 0)
        XCTAssertEqual(mapViewStub.startLoadingCount, 1)
        XCTAssertEqual(mapViewStub.finishLoadingCount, 1)
        XCTAssertEqual(mapViewStub.showErrorCount, 1)
        XCTAssertEqual(mapViewStub.showedErrorText, NetworkError.unknown.localizedDescription)
        
        XCTAssertEqual(mapViewStub.receivedPlacemarksViewModels.count, 0)
        XCTAssertNil(mapViewStub.receivedPlacemarksViewModels.first?.name)
        
        XCTAssertEqual(mapViewInteractorStub.getDataCount, 1)
        XCTAssertEqual(mapViewInteractorStub.loadDataCount, 0)
    }
    
    func testFailureLoadData() {
        // Given
        mapViewInteractorStub.isSuccess = false
        
        // When
        baseMapViewPresenter.reloadData()
        
        // Then
        XCTAssertEqual(mapViewStub.populateMapCount, 0)
        XCTAssertEqual(mapViewStub.startLoadingCount, 1)
        XCTAssertEqual(mapViewStub.finishLoadingCount, 1)
        XCTAssertEqual(mapViewStub.showErrorCount, 1)
        XCTAssertEqual(mapViewStub.showedErrorText, NetworkError.unknown.localizedDescription)
        
        XCTAssertEqual(mapViewStub.receivedPlacemarksViewModels.count, 0)
        XCTAssertNil(mapViewStub.receivedPlacemarksViewModels.first?.name)
        
        XCTAssertEqual(mapViewInteractorStub.getDataCount, 0)
        XCTAssertEqual(mapViewInteractorStub.loadDataCount, 1)
    }
}

private class MapViewInteractorStub: MapViewInteractor {
    var isSuccess: Bool = true
    var getDataCount = 0
    var loadDataCount = 0
    
    required init(parentInteractor interactor: AppDataWorker) {}
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        getDataCount += 1
        if isSuccess {
            success([Placemark.empty])
        } else {
            failure(NetworkError.unknown)
        }
    }
    
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        loadDataCount += 1
        if isSuccess {
            success([Placemark.empty])
        } else {
            failure(NetworkError.unknown)
        }
    }
}
