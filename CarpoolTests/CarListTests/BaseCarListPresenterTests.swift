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

class BaseCarListPresenterTests: XCTestCase {
    private var baseCarListPresenter: BaseCarListPresenter!
    private var carListInteractorFake: CarListInteractorFake!
    private var carListView: CarListViewFake!
    
    override func setUp() {
        super.setUp()
        
        carListView = CarListViewFake()
        carListInteractorFake = CarListInteractorFake(isSuccess: true)
        baseCarListPresenter = BaseCarListPresenter(view: carListView, interactor: carListInteractorFake)
    }
    
    override func tearDown() {
        baseCarListPresenter = nil
        carListView = nil
        carListInteractorFake = nil
        super.tearDown()
    }
    
    func testSuccessfulGetData() {
        // Given
        carListInteractorFake.isSuccess = true
        
        // When
        baseCarListPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 1)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 0)
        XCTAssertNil(carListView.showedError)
        
        XCTAssertEqual(carListInteractorFake.getDataCount, 1)
        XCTAssertEqual(carListInteractorFake.loadDataCount, 0)
    }
    
    func testSuccessfulLoadData() {
        // Given
        carListInteractorFake.isSuccess = true
        
        // When
        baseCarListPresenter.reloadData()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 1)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 0)
        XCTAssertNil(carListView.showedError)
        
        XCTAssertEqual(carListInteractorFake.getDataCount, 0)
        XCTAssertEqual(carListInteractorFake.loadDataCount, 1)
    }
    
    func testFailureGetData() {
        // Given
        carListInteractorFake.isSuccess = false
        
        // When
        baseCarListPresenter.getPlacemarks()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 0)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 1)
        XCTAssertEqual(carListView.showedError as? NetworkError, .unknown)
        
//        XCTAssertEqual(carListView.reloadDataCount.count, 0)
//        XCTAssertNil(carListView.receivedPlacemarksViewModels.first?.name)
//
        XCTAssertEqual(carListInteractorFake.getDataCount, 1)
        XCTAssertEqual(carListInteractorFake.loadDataCount, 0)
    }
    
    func testFailureLoadData() {
        // Given
        carListInteractorFake.isSuccess = false
        
        // When
        baseCarListPresenter.reloadData()
        
        // Then
        XCTAssertEqual(carListView.reloadDataCount, 0)
        XCTAssertEqual(carListView.startLoadingCount, 1)
        XCTAssertEqual(carListView.finishLoadingCount, 1)
        XCTAssertEqual(carListView.showErrorCount, 1)
        XCTAssertEqual(carListView.showedError as? NetworkError, .unknown)
        
        XCTAssertEqual(carListInteractorFake.getDataCount, 0)
        XCTAssertEqual(carListInteractorFake.loadDataCount, 1)
    }
    
    func testGetPlacemarksCount() {
        // Given
        carListInteractorFake.isSuccess = true
        
        // When & Then
        XCTAssertEqual(baseCarListPresenter.getPlacemarksCount(), 3)
    }
    
    func testPlacemarkViewModelForRow() {
        // Given
        carListInteractorFake.isSuccess = true
        
        // When
        let placemarkViewModel = baseCarListPresenter.getViewModelForRow(row: 2)
        
        // Then
        XCTAssertEqual(placemarkViewModel.name, Constants.name)
    }
}

private class CarListInteractorFake: CarListInteractor {
    var isSuccess: Bool = true
    var getDataCount = 0
    var loadDataCount = 0
    
    required init(parentInteractor interactor: AppDataWorker) {}
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func getPlacemarks() -> [Placemark] {
        return [Placemark.empty, Placemark.empty, Placemark()]
    }
    
    func getData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        getDataCount += 1
        execute(success: success, failure: failure)
    }
    
    func reloadData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        loadDataCount += 1
        execute(success: success, failure: failure)
    }
    
    private func execute(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        if isSuccess {
            success()
        } else {
            failure(NetworkError.unknown)
        }
    }
}

private class CarListViewFake: BaseViewFake, CarListView {
    var reloadDataCount = 0
    
    func setPresenter(_ presenter: CarListPresenter) { }
    
    func reloadData() {
        reloadDataCount += 1
    }
}

extension Placemark {
    init() {
        self.init(address: "", coordinates: CGPoint.zero, engineType: "", exterior: .good, fuel: 100, interior: .good, name: Constants.name, vin: "")
    }
}

private enum Constants {
    static let name = "HH-GOOD42"
}

//
//func getViewModelForRow(row: Int) -> PlacemarkListViewModel {
//    guard let placemark = interactor.getPlacemarks()[try: row] else {
//        print(" **** Error: could not retrive placemark \(self.self) \(#line)")
//        return PlacemarkListViewModel.empty
//    }
//
//    return getPlacemarkListViewModel(fromPlacemark: placemark)
//}
//
//func getPlacemarksCount() -> Int {
//    return interactor.getPlacemarks().count
//}
