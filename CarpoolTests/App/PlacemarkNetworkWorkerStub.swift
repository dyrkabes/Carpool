//
//  PlacemarkNetworkWorkerStub.swift
//  CarpoolTests
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

@testable import Carpool
import CPCommon

final class PlacemarksNetworkWorkerStub: PlacemarksNetworkWorker {
    var loadPlacemarksCallsCount = 0
    var shouldSucceed: Bool = true
    
    func loadPlacemarks(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        loadPlacemarksCallsCount += 1
        if shouldSucceed {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                success([Placemark.empty])
            }
        } else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                failure(NetworkError.unknown)
            }
        }
    }
}
