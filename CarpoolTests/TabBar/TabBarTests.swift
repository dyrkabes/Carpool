//
//  TabBarTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//


import XCTest
@testable import Carpool

class TabBarTests: XCTestCase {
    func testOnEnterForeground() {
        // Given
        let tabBar = SceneBuilder.createTabBar()
        let mainInteractorFake = AppMainInteractorFake()
        tabBar.setInteractor(mainInteractorFake)
        
        // When
        tabBar.onEnterForeground()
        
        // Then
        XCTAssertEqual(mainInteractorFake.getDataCount, 0)
        XCTAssertEqual(mainInteractorFake.loadDataCount, 1)
    }
}

private class AppMainInteractorFake: AppDataWorker {
    var getDataCount = 0
    var loadDataCount = 0
    
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        getDataCount += 1
    }
    
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        loadDataCount += 1
    }
    
    
}
