//
//  StubDataProvider.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

/// Loads data from local file.
enum StubDataProvider {
    case locations

    var fileName: String {
        return "\(self)"
    }

    var data: Data? {
        guard let data = FileDataLoader().loadFromJSONFile(fileName) else { return nil }
        return data
    }
}
