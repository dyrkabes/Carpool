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
        let result = Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        return result
    }
}
