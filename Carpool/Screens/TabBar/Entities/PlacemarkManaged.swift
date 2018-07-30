//
//  PlacemarkManaged.swift
//  Carpool
//
//  Created by Pavel Stepanov on 30/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

extension PlacemarkManaged {
    func populate(with placemark: Placemark) {
        self.address = placemark.address
        self.engineType = placemark.engineType
        self.exterior = placemark.exterior.rawValue
        self.fuel = Int16(placemark.fuel)
        self.interior = placemark.interior.rawValue
        self.name = placemark.name
        self.vin = placemark.vin
        self.xCoordinate = Double(placemark.coordinates.x)
        self.yCoordinate = Double(placemark.coordinates.y)
    }
}
