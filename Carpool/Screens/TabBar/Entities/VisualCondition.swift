//
//  VisualCondition.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

/**
 Represents exterior and interior values.
 
 - Discussion: In the case there're more condition types and they could change dynamically I would make a dictionary so cases could be loaded from a separate route in form of [index: description]<Int, String>. In case the uppercased values are important I would make another init :) but I'd still use an enum because this way we're not connected to just a string representation and we could for instance use stars instead of labels.
 */
enum VisualCondition: String, Decodable, CustomStringConvertible {
    case good = "good"
    case unacceptable = "unacceptable"
    
    init?(rawValue: String) {
        let lowercased = rawValue.lowercased()
        switch lowercased {
        case "good":
            self = .good
        case "unacceptable":
            self = .unacceptable
        default:
            return nil
        }
    }
    
    var description: String {
        return self.rawValue.localized()
    }
}
