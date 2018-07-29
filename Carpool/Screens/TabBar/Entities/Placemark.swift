//
//  Placemark.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

struct Placemark: Codable {
    let address: String
    let coordinates: CGPoint
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
    
    static var empty: Placemark {
        return Placemark(address: "", coordinates: CGPoint.zero, engineType: "", exterior: "", fuel: 0, interior: "", name: "", vin: "")
    }
}
