//
//  BaseMapViewInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

final class BaseMapViewInteractor: MapViewInteractor {
    // MARK: - Instance properties
    private var placemarks: [Placemark] = []
    
    // MARK: - Injected
    private unowned var parentInteractor: MainInteractor
    
    // MARK: - Init
    required init(parentInteractor interactor: MainInteractor) {
        self.parentInteractor = interactor
    }
    
    // MARK: - Public func
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        parentInteractor.getData(success: { [weak self] (placemarks) in
            guard let strongSelf = self else { return }
            strongSelf.placemarks = placemarks
            success(placemarks)
        }, failure: failure)
    }
    
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        parentInteractor.loadDataFromNetwork(success: { [weak self] (placemarks) in
                guard let strongSelf = self else { return }
                strongSelf.placemarks = placemarks
                success(placemarks)
        } ,failure: failure)
    }
}
