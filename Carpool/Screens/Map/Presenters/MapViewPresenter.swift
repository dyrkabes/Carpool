//
//  MapViewPresenter.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

protocol MapViewPresenter: class {
    init(view: MapView, interactor: MapViewInteractor)
    
    func getPlacemarks()
    func reloadData()
}
