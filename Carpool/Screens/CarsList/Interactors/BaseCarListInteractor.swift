//
//  BaseCarListInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

final class BaseCarListInteractor: CarListInteractor {
    // MARK: - Injected
    private unowned var parentInteractor: MainInteractor
    
    // MARK: - Instance properties
    fileprivate var placemarks: [Placemark] = []
    
    // MARK: - Init
    init(parentInteractor: MainInteractor) {
        self.parentInteractor = parentInteractor
    }
    
    // MARK: - Public func
    func getData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        parentInteractor.getData(success: { [weak self] (placemarks) in
            self?.placemarks = placemarks
            success()
            }, failure: failure)
    }
    
    func reloadData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        parentInteractor.loadDataFromNetwork(success: { [weak self] (placemarks) in
            self?.placemarks = placemarks
            success()
            }, failure: failure)
    }
    
    func getPlacemarks() -> [Placemark] {
        return placemarks
    }
}
