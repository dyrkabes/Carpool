//
//  PlacemarkListViewModel.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

/**
 View model for displaying cells in the list.
 
 - Note:
 I decided not to include vin as I consider it as a more private information.
 */
struct PlacemarkListViewModel {
    let address: String
    let engineType: String
    let exterior: VisualCondition
    let fuel: Int
    let interior: VisualCondition
    let name: String
    
    static var empty: PlacemarkListViewModel {
        return PlacemarkListViewModel(address: "", engineType: "", exterior: .unacceptable, fuel: 0, interior: .unacceptable, name: "")
    }
}
