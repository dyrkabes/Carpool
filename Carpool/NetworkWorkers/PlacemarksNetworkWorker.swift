//
//  CarsNetworkWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

typealias EmptySuccessHandler = () -> ()
typealias PlacemarksSuccessHandler = ([Placemark]) -> ()
typealias ErrorHandler = (Error) -> ()

protocol PlacemarksNetworkWorker {
    func loadPlacemarks(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
}
