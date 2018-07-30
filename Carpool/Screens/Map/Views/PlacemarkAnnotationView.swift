//
//  PlacemarkAnnotationView.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation
import MapKit
import CPCommon

// WIP: Probably I will just make my own annotationView.
final class PlacemarkAnnotationView: MKMarkerAnnotationView, Identifiable {
    
    // MARK: - Init
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = ClusterAnnotationView.identifier
        displayPriority = .required
        collisionMode = .circle
        
        canShowCallout = false
        
//        subtitleVisibility = MKFeatureVisibility.hidden
        
        titleVisibility = MKFeatureVisibility.hidden
        isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        self.glyphImage = #imageLiteral(resourceName: "Engine")
        
        canShowCallout = false
        
        titleVisibility = MKFeatureVisibility.hidden
        
        isEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        isSelected = selected
        
        if selected {
            titleVisibility = MKFeatureVisibility.visible 
        } else {
            titleVisibility = MKFeatureVisibility.hidden
        }
    }
}

protocol PlacemarkAnnotationViewDelegate {
//    <#requirements#>
}
