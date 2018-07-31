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
        let calloutView = UIView()
        let label = UILabel(frame: CGRect.zero)
        if let title = self.annotation?.title {
            label.text = title
        }
        label.font = label.font.withSize(14)
        label.textColor = UIColor(hex: 0x4B4B4B)
        label.sizeToFit()
        
        let viewWidth = label.frame.width + 10
        let viewHeight = label.frame.height + 10
        
        calloutView.addSubview(label)
        calloutView.frame = CGRect(x: -viewWidth/2 + self.frame.width/2, y: -70, width: viewWidth, height: viewHeight)
        calloutView.backgroundColor = UIColor(hex: 0xCBCBCB)
        calloutView.layer.cornerRadius = viewHeight / 2
        
        label.frame.origin = label.frame.origin.applying(CGAffineTransform(translationX: 5, y: 5))
        
        return calloutView
    }()
    
    weak var delegate: PlacemarkAnnotationViewDelegate?
    
    // MARK: - Init
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = ClusterAnnotation.identifier
        displayPriority = .required
        collisionMode = .circle
        isEnabled = true
        canShowCallout = false
        isEnabled = true
        
        titleVisibility = .hidden
        
//        canShowCallout = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        canShowCallout = false
        isEnabled = true
        
        titleVisibility = .hidden
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
//        self.glyphImage = #imageLiteral(resourceName: "Engine")
        
//        canShowCallout = false
        
//        titleVisibility = MKFeatureVisibility.hidden
        
        isEnabled = true
        canShowCallout = false
        isEnabled = true
        
        titleVisibility = .hidden
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        canShowCallout = false
//        titleVisibility = MKFeatureVisibility.hidden
        canShowCallout = false
        isEnabled = true
        
        titleVisibility = .hidden
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        nameLabel.isHidden = true
        
        if isSelected {
            addSubview(nameLabel)
        } else {
            nameLabel.removeFromSuperview()
        }
        
        delegate?.didChangeAnnotation(annotation, toSelectedState: isSelected)
    }
}

protocol PlacemarkAnnotationViewDelegate: class {
    func didChangeAnnotation(_ annotation: MKAnnotation?, toSelectedState isSelected: Bool)
}
