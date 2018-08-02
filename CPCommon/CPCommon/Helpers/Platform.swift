//
//  Platform.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 03/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

public struct Platform {
    public static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
