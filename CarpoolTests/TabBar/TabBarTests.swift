//
//  TabBarTests.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//


import XCTest
@testable import Carpool

final class TabBarTests: XCTestCase {
    func testOnEnterForeground() {
        // Given
        let tabBar = SceneBuilder.createTabBar()
        let mainInteractorStub = MainInteractorStub()
        tabBar.setInteractor(mainInteractorStub)
        
        // When
        tabBar.onEnterForeground()
        
        // Then
        XCTAssertEqual(mainInteractorStub.getDataCount, 0)
        XCTAssertEqual(mainInteractorStub.loadDataCount, 1)
    }
}
