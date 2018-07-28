//
//  BaseCarListInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

class BaseCarListInteractor: CarListInteractor {
    private weak var view: CarListViewController?
    
    required init(viewController: CarListViewController) {
        self.view = viewController
    }
}
