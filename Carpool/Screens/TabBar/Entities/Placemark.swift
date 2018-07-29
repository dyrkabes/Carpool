//
//  Placemark.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

/**
 Represents a placemark model received from the backend.
 
 - Discussion: I was not sure what fields are required so.. I made all of them required :)
 */
struct Placemark: Decodable {
    let address: String
    let coordinates: CGPoint
    let engineType: String
    let exterior: VisualCondition
    let fuel: Int
    let interior: VisualCondition
    let name: String
    let vin: String
    
    // MARK: - Init
    static var empty: Placemark {
        return Placemark(address: "", coordinates: CGPoint.zero, engineType: "", exterior: .unacceptable, fuel: 0, interior: .unacceptable, name: "", vin: "")
    }
    
    init(address: String, coordinates: CGPoint, engineType: String, exterior: VisualCondition, fuel: Int, interior: VisualCondition, name: String, vin: String) {
        self.address = address
        self.coordinates = coordinates
        self.engineType = engineType
        self.exterior = exterior
        self.fuel = fuel
        self.interior = interior
        self.name = name
        self.vin = vin
    }
    
    init?(managedObject: PlacemarkManaged) {
        guard let address = managedObject.address,
            let engineType = managedObject.engineType,
            let exterior = managedObject.exterior,
            let interior = managedObject.interior,
            let name = managedObject.name,
            let vin = managedObject.vin else { return nil }
        
        self.address = address
        self.coordinates = CGPoint(x: managedObject.xCoordinate, y: managedObject.yCoordinate)
        self.engineType = engineType
        self.exterior = VisualCondition(rawValue: exterior) ?? .unacceptable
        self.fuel = Int(managedObject.fuel)
        self.interior = VisualCondition(rawValue: interior) ?? .unacceptable
        self.name = name
        self.vin = vin
    }
}


