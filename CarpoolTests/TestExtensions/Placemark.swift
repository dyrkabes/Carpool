//
//  Placemark.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool
import UIKit

extension Placemark {
    init() {
        self.init(address: "", coordinates: CGPoint.zero, engineType: "", exterior: .good, fuel: 100, interior: .good, name: CPTestConstants.placemarkName, vin: "")
    }
}
