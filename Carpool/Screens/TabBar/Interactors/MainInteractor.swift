//
//  TabBarInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

protocol MainInteractor: class {
    init(networkWorker: PlacemarksNetworkWorker, storageWorker: PersistentStorageWorker)
    
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
    
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler)
}
