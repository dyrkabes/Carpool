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
    
    static var empty: Placemark {
        return Placemark(address: "", coordinates: CGPoint.zero, engineType: "", exterior: .unacceptable, fuel: 0, interior: .unacceptable, name: "", vin: "")
    }
}
