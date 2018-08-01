//
//  ClusterAnnotationView.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import MapKit
import CPCommon

final class ClusterAnnotation: MKClusterAnnotation, Identifiable {
    override init(memberAnnotations: [MKAnnotation]) {
        super.init(memberAnnotations: memberAnnotations)
        title = nil
        subtitle = nil
    }
}
