//
//  Collection+try.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns an element with the specified index or nil if the element does not exist.
    ///
    /// - Parameters:
    ///   - try: The index of the element.
    public subscript(try index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
