//
//  CarListInteractorStub.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool
import CPCommon

final class CarListInteractorStub: CarListInteractor {
    var isSuccess: Bool = true
    var getDataCount = 0
    var loadDataCount = 0
    
    required init(parentInteractor interactor: AppDataWorker) {}
    
    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }
    
    func getPlacemarks() -> [Placemark] {
        return [Placemark.empty, Placemark.empty, Placemark()]
    }
    
    func getData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        getDataCount += 1
        execute(success: success, failure: failure)
    }
    
    func reloadData(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        loadDataCount += 1
        execute(success: success, failure: failure)
    }
    
    private func execute(success: @escaping EmptySuccessHandler, failure: @escaping ErrorHandler) {
        if isSuccess {
            success()
        } else {
            failure(NetworkError.unknown)
        }
    }
}
