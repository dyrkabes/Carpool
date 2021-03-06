//
//  CLLocationCoordinate2D+Init.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import CoreLocation

extension CLLocationCoordinate2D {
    public init(coordinates: CGPoint) {
        self.init(latitude: CLLocationDegrees(coordinates.y), longitude: CLLocationDegrees(coordinates.x))
    }
}
