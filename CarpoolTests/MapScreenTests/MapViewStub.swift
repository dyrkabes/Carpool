//
//  MapViewStub.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool
import CoreLocation

class MapViewStub: BaseViewStub, MapView {
    var populateMapCount = 0
    
    var receivedPlacemarksViewModels: [PlacemarkMapViewModel] = []
    
    func setPresenter(_ presenter: MapViewPresenter) {}
    
    func populateMap(withViewData viewData: [PlacemarkMapViewModel]) {
        populateMapCount += 1
        receivedPlacemarksViewModels = viewData
    }
    
    func centerMap(center: CLLocationCoordinate2D, isAnimated: Bool) { }
}
