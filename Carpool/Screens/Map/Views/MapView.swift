//
//  MapView.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon
import CoreLocation

protocol MapView: AppViewController {
    func setPresenter(_ presenter: MapViewPresenter)
    
    func centerMap(center: CLLocationCoordinate2D, isAnimated: Bool)
    func populateMap(withViewData viewData: [PlacemarkMapViewModel])
}
