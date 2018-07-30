//
//  UIButton+Localized.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

/**
 Set of extensions to localize
 
 - Discussion: For UI components with attributedText another localization function should be implemented.
 */
extension UILabel {
    override open func awakeFromNib() {
        super.awakeFromNib()
        setLocalized()
    }
    
    func setLocalized() {
        self.text = self.text?.localized()
    }
}

extension UITabBarItem {
    override open func awakeFromNib() {
        super.awakeFromNib()
        setLocalized()
    }
    
    func setLocalized() {
        self.title = self.title?.localized()
    }
}
