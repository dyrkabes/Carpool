//
//  PlacemarkHandlerWrapper.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

/// Contains closures to be called in case the request is already in progress
final class PlacemarkHandlerWrapper {
    var success: PlacemarksSuccessHandler
    var failure: ErrorHandler
    
    init(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        self.success = success
        self.failure = failure
    }
}
