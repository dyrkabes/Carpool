//
//  PlacemarkMapViewModel.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation
import MapKit

class PlacemarkMapViewModel: NSObject, MKAnnotation {
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinates: CGPoint) {
        self.name = name
        self.coordinate = CLLocationCoordinate2D(coordinates: coordinates)
    }
}
