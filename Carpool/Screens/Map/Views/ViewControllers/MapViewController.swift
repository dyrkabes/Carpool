//
//  SecondViewController.swift
//  Carpool
//
//  Created by Pavel Stepanov on 27/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import MapKit
import CPCommon

final class MapViewController: BaseViewController, MapView {
    // MARK: - Instance properties
    private lazy var locationManager: CLLocationManager = self.createLocationManager()
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Injected
    private var presenter: MapViewPresenter!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getPlacemarks()
    }
    
    // MARK: - Public func
    func setPresenter(_ presenter: MapViewPresenter) {
        self.presenter = presenter
    }
    
    func reload(withViewData viewData: [PlacemarkMapViewModel]) {
        mapView.addAnnotations(viewData)
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PlacemarkMapViewModel else { return nil }
        let identifier = PlacemarkAnnotationView.identifier
        var view: PlacemarkAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? PlacemarkAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = PlacemarkAnnotationView(annotation: annotation, reuseIdentifier: identifier)  // TODO: unify register identifier
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

// MARK: - Private func
extension MapViewController {
    private func setupView() {
        mapView.delegate = self
        registerAnnotationViewClass()
        
        let center = CLLocationCoordinate2DMake(53.54, 10.1)
        let region = MKCoordinateRegionMakeWithDistance(center, 30000, 30000)
        mapView.setRegion(region, animated: false)
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func registerAnnotationViewClass() {
        mapView.register(PlacemarkAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlacemarkAnnotationView.identifier)
    }
    
    private func createLocationManager() -> CLLocationManager {
        let manager = CLLocationManager()
        manager.startUpdatingLocation()
        return manager
    }
}

