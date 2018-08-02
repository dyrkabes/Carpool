//
//  CarListViewStub.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool

final class CarListViewStub: BaseViewStub, CarListView {
    var reloadDataCount = 0
    
    func setPresenter(_ presenter: CarListPresenter) { }
    
    func reloadData() {
        reloadDataCount += 1
    }
}
