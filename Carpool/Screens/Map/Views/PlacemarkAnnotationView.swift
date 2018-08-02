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

final class PlacemarkAnnotationView: MKMarkerAnnotationView, Identifiable {
    // MARK: - UI
    private lazy var calloutView: UIView = {
        let title: String? = self.annotation?.title ?? nil
        
        let calloutView = PlacemarkCalloutView(title: title)
        
        calloutView.frame = CGRect(x: -calloutView.frame.width/2 + self.frame.width/2,
                                   y: -Constants.selectedMarkerHeight,
                                   width: calloutView.frame.width,
                                   height: calloutView.frame.height)
        return calloutView
    }()

    // MARK: - Init
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configureAnnotationView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureAnnotationView()
    }
    
    // MARK: - View lifecycle
    override func prepareForDisplay() {
        super.prepareForDisplay()
        canShowCallout = false
    }

    // MARK: - Public func
    func showCallout() {
        addSubview(calloutView)
    }

    func hideCallout() {
        calloutView.removeFromSuperview()
    }
}

// MARK: - UI Helpers
extension PlacemarkAnnotationView {
    private func configureAnnotationView() {
        clusteringIdentifier = ClusterAnnotation.identifier
        displayPriority = .required
        collisionMode = .circle
        titleVisibility = .hidden
    }
}

private enum Constants {
    static let selectedMarkerHeight: CGFloat = 72.0
}
