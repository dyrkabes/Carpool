//
//  MapViewInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

protocol MapViewInteractor: class {
    init(parentInteractor interactor: AppDataWorker)
    
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
}
