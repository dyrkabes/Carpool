//
//  CPConstants.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 30/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

public enum CPConstants {
    public static let modelName = "Carpool"
    
    /**
     App's color constants.
     
     - Discussion: In case a different color palette is needed implement injectable object and pass it via the app coordinator.
    */
    public enum Colors {
        public static let calloutBackground: UIColor = UIColor(hex: 0xECECEC)
        public static let mainTextColor: UIColor = UIColor(hex: 0x4B4B4B)
        public static let shadowColor: CGColor = UIColor(hex: 0xC4CAD6).cgColor
    }
}
