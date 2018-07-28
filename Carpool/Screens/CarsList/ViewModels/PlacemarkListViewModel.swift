//
//  PlacemarkListViewModel.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

struct PlacemarkListViewModel {
    let address: String
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
    
    static var empty: PlacemarkListViewModel {
        return PlacemarkListViewModel(address: "", engineType: "", exterior: "", fuel: 0, interior: "", name: "", vin: "")
    }
}
