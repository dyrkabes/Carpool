//
//  PlacemarkMapViewModel.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation
import MapKit

final class PlacemarkMapViewModel: NSObject, MKAnnotation {
    let address: String
    let coordinate: CLLocationCoordinate2D
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
    
    var title: String? {
        return name
    }
    
    init(address: String, coordinates: CGPoint, engineType: String, exterior: String, fuel: Int, interior: String,  name: String, vin: String) {
        self.address = address
        self.coordinate = CLLocationCoordinate2D(coordinates: coordinates)
        self.engineType = engineType
        self.exterior = exterior
        self.fuel = fuel
        self.interior = interior
        self.name = name
        self.vin = vin
    }
}

