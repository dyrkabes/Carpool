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
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        subscribeToEnterForeground()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribe()
    }
    
    // MARK: - Public func
    func setPresenter(_ presenter: MapViewPresenter) {
        self.presenter = presenter
    }
    
    // TODO: Think about a better solution
    func populateMap(withViewData viewData: [PlacemarkMapViewModel]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(viewData)
        print(viewData.count)
    }
    
    @objc private func getData() {
        presenter.getPlacemarks()
    }
    
    // MARK: - Subscriptions
    private func subscribeToEnterForeground() {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    private func unsubscribe() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
//        if annotation is MKClusterAnnotation {
//            return MKPinAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        }
        
        guard let annotation = annotation as? PlacemarkMapViewModel else { return nil }
        let identifier = PlacemarkAnnotationView.identifier
        var view: PlacemarkAnnotationView
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? PlacemarkAnnotationView {
            annotationView.annotation = annotation
            view = annotationView
        } else {
            view = PlacemarkAnnotationView(annotation: annotation, reuseIdentifier: identifier)  
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
 
        view.delegate = self
        view.clusteringIdentifier = ClusterAnnotation.identifier
        return view
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let cluster = ClusterAnnotation(memberAnnotations: memberAnnotations)
        return cluster
    }
}

// MARK: - PlacemarkAnnotationViewDelegate
// TODO: Write possible optimiz
extension MapViewController: PlacemarkAnnotationViewDelegate {
    func didChangeAnnotation(_ annotation: MKAnnotation?, toSelectedState isSelected: Bool) {
        guard let annotation = annotation else {
            print("JKJJ")
            return
        }
        if isSelected {
            mapView.removeAnnotations(mapView.annotations.filter { $0 !== annotation })
        } else {
            // get data is called twice. This method is called twice. It should not. And it should not result in 2 additions -> 1
            // and it should not be called twice. It happens due to some deselection
            print("ÄA")
            getData()
        }
    }
    
    // TODO: To presentar
}

// MARK: - Helpers
extension MapViewController {
    private func setupView() {
        mapView.delegate = self
        registerAnnotationViewClass()
        
        // TODO: User's location
        let center = CLLocationCoordinate2DMake(53.54, 10.1)
        centerMap(center: center, isAnimated: false)
        
        title = AppTexts.map
    }
    
    private func registerAnnotationViewClass() {
        mapView.register(PlacemarkAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    private func createLocationManager() -> CLLocationManager {
        let manager = CLLocationManager()
        manager.startUpdatingLocation()
        return manager
    }
    
    private func centerMap(center: CLLocationCoordinate2D, isAnimated: Bool) {
        let region = MKCoordinateRegionMakeWithDistance(center, 30000, 30000)
        mapView.setRegion(region, animated: false)
    }
}

