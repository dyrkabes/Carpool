//
//  AppDataWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

/// Is responsible for getting and loading data.
protocol AppDataWorker: class {
    /// Gets data from the persistent storage.
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
    
    /// Updates data from network.
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
}
