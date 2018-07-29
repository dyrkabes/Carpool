//
//  LocalPlacemarksNetworkWorker.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

struct LocalPlacemarksNetworkWorker: PlacemarksNetworkWorker {
    // MARK: - Instance properties
    private let placemarksData: Data?
    
    // MARK: - Init
    init(placemarksData: Data?) {
        self.placemarksData = placemarksData
    }
    
    // MARK: - Public func
    func loadPlacemarks(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        let decoder = JSONDecoder()
        
        guard let placemarksData = placemarksData else {
            failure(NetworkError.unknown)
            return
        }
        
        guard let placemarksDictionary: [String: [Placemark]] = try? decoder.decode([String: [Placemark]].self, from: placemarksData),
            let placemarks = placemarksDictionary[Keys.placemarks] else {
            failure(NetworkError.parsingFailure)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            success(placemarks)
        }
    }
}

private enum Keys {
    static let placemarks = "placemarks"
}
