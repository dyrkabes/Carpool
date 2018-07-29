//
//  StubDataProvider.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

enum StubDataProvider {
    case locations
    
    var fileName: String {
        return "\(self)"
    }
    
    // enum Status { // TODO
    // case success
    // case failure
    // }
    
    // func data(status: Status) -> Data {
    
    // Or even make a server
    var data: Data? {
        guard let data = FileDataLoader().loadFromJSONFile(fileName) else { return nil }
        return data
    }
}
