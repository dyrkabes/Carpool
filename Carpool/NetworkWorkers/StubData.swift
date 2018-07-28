//
//  StubData.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

enum StubData {
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
    var data: Data {
        return FileDataLoader().loadFromJSONFile(fileName)!
    }
}

//        let data = stL.loadFromJSONFile("locations")
//
//
//        let decoder = JSONDecoder()
//
//        guard let allPlacemarks: [String: [Placemark]] = try? decoder.decode([String: [Placemark]].self, from: data) else {
//            return nil
//        }
//
//        return placemarks["placemarks"]


