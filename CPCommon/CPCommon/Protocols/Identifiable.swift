//
//  Identifiable.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

/// Provides implementation for returning class identifier for registering in data sources
public protocol Identifiable: class {
    static var identifier: String { get }
}

extension Identifiable {
    public static var identifier: String {
        get {
            return "\(Self.self)"
        }
    }
}
