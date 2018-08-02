//
//  BaseViewFake.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 01/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool

class BaseViewFake {
    var startLoadingCount = 0
    var finishLoadingCount = 0
    var showErrorCount = 0
    var showedErrorText: String?
    
    func startLoading() {
        startLoadingCount += 1
    }
    
    func finishLoading() {
        finishLoadingCount += 1
    }
    
    func showError(message: String) {
        showErrorCount += 1
        showedErrorText = message
    }
}
