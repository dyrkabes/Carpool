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
    private lazy var nameLabel: UIView = {
        return createCalloutView()
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
        addSubview(nameLabel)
    }

    func hideCallout() {
        nameLabel.removeFromSuperview()
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

    private func createCalloutView() -> UIView {
        let calloutView = UIView()
        calloutView.backgroundColor = CPConstants.Colors.calloutBackground

        let label = UILabel(frame: CGRect.zero)
        if let title = self.annotation?.title {
            label.text = title
        }
        label.font = label.font.withSize(14)
        label.textColor = CPConstants.Colors.mainTextColor
        label.sizeToFit()

        let viewWidth = label.frame.width + Constants.horizontalPadding
        let viewHeight = label.frame.height + Constants.verticalPadding

        calloutView.addSubview(label)
        calloutView.frame = CGRect(x: -viewWidth/2 + self.frame.width/2,
                                   y: -Constants.selectedMarkerHeight,
                                   width: viewWidth,
                                   height: viewHeight)
        calloutView.layer.cornerRadius = viewHeight / 2

        label.frame.origin = label
            .frame
            .origin
            .applying(CGAffineTransform(translationX: Constants.horizontalPadding/2,
                                        y: Constants.verticalPadding/2))
        calloutView.setupCardShadow(offset: CGSize(width: 0, height: 2), path: nil)

        return calloutView
    }
}

private enum Constants {
    static let horizontalPadding: CGFloat = 20.0
    static let verticalPadding: CGFloat = 10.0

    static let selectedMarkerHeight: CGFloat = 72.0
}
