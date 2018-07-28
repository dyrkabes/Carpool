//
//  CarListInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

protocol CarListInteractor {
    init(parentInteractor: MainInteractor)
    
    func getPlacemarks() -> [Placemark]
    func setPresenter(_ presenter: CarListPresenter)
    
    func getData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler)
    func reloadData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler)
}
