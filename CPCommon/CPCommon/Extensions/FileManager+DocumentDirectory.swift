//
//  FileManager+DocumentDirectory.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 30/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

extension FileManager {
    public static var documentDirectory: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
