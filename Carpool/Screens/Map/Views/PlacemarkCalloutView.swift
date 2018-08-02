//
//  PlacemarkCalloutView.swift
//  Carpool
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import CPCommon

class PlacemarkCalloutView: UIView {
    init(title: String?) {
        super.init(frame: CGRect.zero)
        backgroundColor = CPConstants.Colors.calloutBackground
        
        let label = UILabel(frame: CGRect.zero)
        if let title = title {
            label.text = title
        }
        label.font = label.font.withSize(14)
        label.textColor = CPConstants.Colors.mainTextColor
        label.sizeToFit()
        
        let viewWidth = label.frame.width + Constants.horizontalPadding
        let viewHeight = label.frame.height + Constants.verticalPadding
        
        addSubview(label)
        
        frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        
        layer.cornerRadius = viewHeight / 2
        
        label.frame.origin = label
            .frame
            .origin
            .applying(CGAffineTransform(translationX: Constants.horizontalPadding/2,
                                        y: Constants.verticalPadding/2))
        setupCardShadow(offset: CGSize(width: 0, height: 2), path: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private enum Constants {
    static let horizontalPadding: CGFloat = 20.0
    static let verticalPadding: CGFloat = 10.0
}
