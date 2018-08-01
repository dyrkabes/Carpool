//
//  UIView+Shadow.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

extension UIView {
    public func setupCardShadow(offset: CGSize? = nil, path: CGPath? = nil) {
        self.layer.shadowOffset = offset ?? Constants.shadowOffset
        
        self.layer.shadowColor = Constants.shadowColor
        self.layer.shadowOpacity = Constants.shadowOpacity
        self.layer.shadowRadius = Constants.shadowRadius
        self.layer.shadowPath = path
    }
}

private enum Constants {
    static let shadowOffset = CGSize(width: 1, height: 0.5)
    static let shadowRadius: CGFloat = 1.0
    static let shadowOpacity: Float = 1.0
    static let shadowColor = CPConstants.Colors.shadowColor
}
