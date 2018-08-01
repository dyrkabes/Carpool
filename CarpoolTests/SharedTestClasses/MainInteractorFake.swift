//
//  MainInteractorFake.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon
@testable import Carpool

class MainInteractorFake: AppDataWorker {
    var getDataCount = 0
    var loadDataCount = 0
    var isSuccess: Bool
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    init() {
        isSuccess = true
    }
    
    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        getDataCount += 1
        if isSuccess {
            success([Placemark.empty])
        } else {
            failure(NetworkError.unknown)
        }
    }
    
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        loadDataCount += 1
        
        if isSuccess {
            success([Placemark.empty])
        } else {
            failure(NetworkError.unknown)
        }
    }
}
