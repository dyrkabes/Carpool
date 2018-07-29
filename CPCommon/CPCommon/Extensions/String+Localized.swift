//
//  String+Localized.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

extension String {
    public func localized() -> String {
        // TODO: Create more universal bundle retrieving mechanics
        guard let bundle = Bundle(identifier: "com.dyrkabes.CPCommon") else {
            print(" **** Error: could not retrieve bundle \(self.self) \(#line)")
            return ""
        }
        let result = bundle.localizedString(forKey: self, value: nil, table: nil)
        return result
    }
}
