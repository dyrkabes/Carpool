//
//  BaseMapViewPresenterTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
@testable import Carpool

class BaseMapViewPresenterTests: XCTestCase {
    private var baseMapViewPresenter: BaseMapViewPresenter!
    private var mapViewInteractorFake: MapViewInteractorFake!
    private var mapViewFake: MapViewFake!
    
    override func setUp() {
        super.setUp()
        
        mapViewFake = MapViewFake()
        mapViewInteractorFake = MapViewInteractorFake(isSuccess: true)
        baseMapViewPresenter = BaseMapViewPresenter(view: mapViewFake, interactor: mapViewInteractorFake)
    }
    
    override func tearDown() {
        baseMapViewPresenter = nil
        mapViewFake = nil
        mapViewInteractorFake = nil
        super.tearDown()
    }
    
    func testSuccessfulGetData() {
        // Given
        mapViewInteractorFake.isSuccess = true
        
        // When
        baseMapViewPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(mapViewFake.populateMapCount, 1)
        XCTAssertEqual(mapViewFake.startLoadingCount, 1)
        XCTAssertEqual(mapViewFake.finishLoadingCount, 1)
        XCTAssertEqual(mapViewFake.showErrorCount, 0)
        XCTAssertNil(mapViewFake.showedError)
        
        XCTAssertEqual(mapViewFake.receivedPlacemarksViewModels.count, 1)
        XCTAssertEqual(mapViewFake.receivedPlacemarksViewModels.first?.name, "")
        
        XCTAssertEqual(mapViewInteractorFake.getDataCount, 1)
        XCTAssertEqual(mapViewInteractorFake.loadDataCount, 0)
    }
    
    func testSuccessfulLoadData() {
        // Given
        mapViewInteractorFake.isSuccess = true
        
        // When
        baseMapViewPresenter.reloadData()
        
        // Then
        XCTAssertEqual(mapViewFake.populateMapCount, 1)
        XCTAssertEqual(mapViewFake.startLoadingCount, 1)
        XCTAssertEqual(mapViewFake.finishLoadingCount, 1)
        XCTAssertEqual(mapViewFake.showErrorCount, 0)
        XCTAssertNil(mapViewFake.showedError)
        
        XCTAssertEqual(mapViewFake.receivedPlacemarksViewModels.count, 1)
        XCTAssertEqual(mapViewFake.receivedPlacemarksViewModels.first?.name, "")
        
        XCTAssertEqual(mapViewInteractorFake.getDataCount, 0)
        XCTAssertEqual(mapViewInteractorFake.loadDataCount, 1)
    }
    
    func testFailureGetData() {
        // Given
        mapViewInteractorFake.isSuccess = false
        
        // When
        baseMapViewPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(mapViewFake.populateMapCount, 0)
        XCTAssertEqual(mapViewFake.startLoadingCount, 1)
        XCTAssertEqual(mapViewFake.finishLoadingCount, 1)
        XCTAssertEqual(mapViewFake.showErrorCount, 1)
        XCTAssertEqual(mapViewFake.showedError as? NetworkError, .unknown)
        
        XCTAssertEqual(mapViewFake.receivedPlacemarksViewModels.count, 0)
        XCTAssertNil(mapViewFake.receivedPlacemarksViewModels.first?.name)
        
        XCTAssertEqual(mapViewInteractorFake.getDataCount, 1)
        XCTAssertEqual(mapViewInteractorFake.loadDataCount, 0)
    }
    
    func testFailureLoadData() {
        // Given
        mapViewInteractorFake.isSuccess = false
        
        // When
        baseMapViewPresenter.reloadData()
        
        // Then
        XCTAssertEqual(mapViewFake.populateMapCount, 0)
        XCTAssertEqual(mapViewFake.startLoadingCount, 1)
        XCTAssertEqual(mapViewFake.finishLoadingCount, 1)
        XCTAssertEqual(mapViewFake.showErrorCount, 1)
        XCTAssertEqual(mapViewFake.showedError as? NetworkError, .unknown)
        
        XCTAssertEqual(mapViewFake.receivedPlacemarksViewModels.count, 0)
        XCTAssertNil(mapViewFake.receivedPlacemarksViewModels.first?.name)
        
        XCTAssertEqual(mapViewInteractorFake.getDataCount, 0)
        XCTAssertEqual(mapViewInteractorFake.loadDataCount, 1)
    }
}

private class MapViewInteractorFake: MapViewInteractor {
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

private class MapViewFake: BaseViewFake, MapView {
    var populateMapCount = 0
    
    var receivedPlacemarksViewModels: [PlacemarkMapViewModel] = []
    
    func setPresenter(_ presenter: MapViewPresenter) {}
    
    func populateMap(withViewData viewData: [PlacemarkMapViewModel]) {
        populateMapCount += 1
        receivedPlacemarksViewModels = viewData
    }
}
