//
//  LocationError.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

public enum LocationError: Error, LocalizedError {
    case userDeclined
    
    public var localizedDescription: String {
        switch self {
        case .userDeclined:
            return AppTexts.userDeclinedError
        }
    }
}
