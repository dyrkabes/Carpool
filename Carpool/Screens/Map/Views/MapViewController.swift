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

/**
 - Note:
 If the logic in MKMapViewDelegate functions was more complex I would move it to presenter.
 */
final class MapViewController: BaseViewController, MapView {
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Injected
    private var presenter: MapViewPresenter!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
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
    
    func centerMap(center: CLLocationCoordinate2D, isAnimated: Bool) {
        let region = MKCoordinateRegionMakeWithDistance(center,
                                                        CPConstants.Location.startingRegionMeters,
                                                        CPConstants.Location.startingRegionMeters)
        mapView.setRegion(region, animated: false)
    }
    
    func populateMap(withViewData viewData: [PlacemarkMapViewModel]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(viewData)
    }
    
    @objc private func getData() {
        presenter.getPlacemarks()
    }
    
    // MARK: - Action
    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        presenter.reloadData()
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
        guard let annotation = annotation as? PlacemarkMapViewModel else { return nil }
        let identifier = PlacemarkAnnotationView.identifier
        var view: PlacemarkAnnotationView
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? PlacemarkAnnotationView {
            annotationView.annotation = annotation
            view = annotationView
        } else {
            view = PlacemarkAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
 
        view.clusteringIdentifier = ClusterAnnotation.identifier
        return view
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let cluster = ClusterAnnotation(memberAnnotations: memberAnnotations)
        return cluster
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let view = view as? PlacemarkAnnotationView else { return }
        view.showCallout()
        guard let annotation = view.annotation else { return }
        mapView.removeAnnotations(mapView.annotations.filter { $0 !== annotation })
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let view = view as? PlacemarkAnnotationView else { return }
        view.hideCallout()
        getData()
    }
}

// MARK: - Helpers
extension MapViewController {
    private func setupView() {
        mapView.delegate = self
        registerAnnotationViewClass()
        
        title = AppTexts.map
    }
    
    private func registerAnnotationViewClass() {
        mapView.register(PlacemarkAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
}
