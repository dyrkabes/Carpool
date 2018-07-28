//
//  StubbedCarsNetworkWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

struct StubbedPlacemarksNetworkWorker: PlacemarksNetworkWorker {
    func loadPlacemarks(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        let placemarksData = StubData.locations.data
        
        let decoder = JSONDecoder()
        guard let allPlacemarks: [String: [Placemark]] = try? decoder.decode([String: [Placemark]].self, from: placemarksData),
            let placemarks = allPlacemarks[Keys.placemarks] else {
            failure(NetworkError.parsingFailure)
            return
        }
        
        success(placemarks)
    }
}

private enum Keys {
    static let placemarks = "placemarks"
}
