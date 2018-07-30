//
//  ClusterAnnotationView.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import MapKit
import CPCommon

// TOTAL WIP. Commiting to switch to another notebook :/
final class ClusterAnnotationView: MKMarkerAnnotationView, Identifiable {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        
        self.tintColor = .green
        
        self.clusteringIdentifier = ClusterAnnotationView.identifier
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        self.tintColor = .black
        
        
        self.glyphImage = #imageLiteral(resourceName: "Car")
    }
    
}
