//
//  BaseCarListPresenterTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import XCTest
import CPCommon
@testable import Carpool

final class BaseCarListPresenterTests: XCTestCase {
    private var baseCarListPresenter: BaseCarListPresenter!
    private var carListInteractorStub: CarListInteractorStub!
    private var carListView: CarListViewStub!
    
    override func setUp() {
        super.setUp()
        
        carListView = CarListViewStub()
        carListInteractorStub = CarListInteractorStub(isSuccess: true)
        baseCarListPresenter = BaseCarListPresenter(view: carListView, interactor: carListInteractorStub)
    }
    
    override func tearDown() {
        baseCarListPresenter = nil
        carListView = nil
        carListInteractorStub = nil
        super.tearDown()
    }
    
    func testSuccessfulGetData() {
        // Given
        carListInteractorStub.isSuccess = true
        
        // When
        baseCarListPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 1)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 0)
        XCTAssertNil(carListView.showedErrorText)
        
        XCTAssertEqual(carListInteractorStub.getDataCount, 1)
        XCTAssertEqual(carListInteractorStub.loadDataCount, 0)
    }
    
    func testSuccessfulLoadData() {
        // Given
        carListInteractorStub.isSuccess = true
        
        // When
        baseCarListPresenter.reloadData()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 1)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 0)
        XCTAssertNil(carListView.showedErrorText)
        
        XCTAssertEqual(carListInteractorStub.getDataCount, 0)
        XCTAssertEqual(carListInteractorStub.loadDataCount, 1)
    }
    
    func testFailureGetData() {
        // Given
        carListInteractorStub.isSuccess = false
        
        // When
        baseCarListPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 0)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 1)
        XCTAssertEqual(carListView.showedErrorText, NetworkError.unknown.localizedDescription)
        
        XCTAssertEqual(carListInteractorStub.getDataCount, 1)
        XCTAssertEqual(carListInteractorStub.loadDataCount, 0)
    }
    
    func testFailureLoadData() {
        // Given
        carListInteractorStub.isSuccess = false
        
        // When
        baseCarListPresenter.reloadData()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 0)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 1)
        XCTAssertEqual(carListView.showedErrorText, NetworkError.unknown.localizedDescription)
        
        XCTAssertEqual(carListInteractorStub.getDataCount, 0)
        XCTAssertEqual(carListInteractorStub.loadDataCount, 1)
    }
    
    func testGetPlacemarksCount() {
        // Given
        carListInteractorStub.isSuccess = true
        
        // When & Then
        XCTAssertEqual(baseCarListPresenter.getPlacemarksCount(), 3)
    }
    
    func testPlacemarkViewModelForRow() {
        // Given
        carListInteractorStub.isSuccess = true
        
        // When
        let placemarkViewModel = baseCarListPresenter.getViewModelForRow(row: 2)
        
        // Then
        XCTAssertEqual(placemarkViewModel.name, CPTestConstants.placemarkName)
    }
}
