//
//  MapViewPresenter.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CoreLocation

protocol MapViewPresenter: class {
    init(view: MapView, interactor: MapViewInteractor)
    
    func viewDidLoad()
    func getPlacemarks()
    func reloadData()
}
