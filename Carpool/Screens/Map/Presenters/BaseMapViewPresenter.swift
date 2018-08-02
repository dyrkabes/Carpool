//
//  BaseMapViewPresenter.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CoreLocation
import CPCommon

/**
 - TODO:
 Use location manager via protocol to ensure proper testing.
 */
final class BaseMapViewPresenter: NSObject, MapViewPresenter {
    // MARK: - Injected
    private unowned let view: MapView
    private let interactor: MapViewInteractor
    private lazy var locationManager: CLLocationManager = CLLocationManager()

    // MARK: - Init
    required init(view: MapView, interactor: MapViewInteractor) {
        self.view = view
        self.interactor = interactor
    }

    // MARK: - Public func
    func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestLocation()
        
        if let userLocation = locationManager.location {
            view.centerMap(center: userLocation.coordinate, isAnimated: true)
        } else {
            view.startLoading()
            if let startingLocationAccuracy = CPConstants.Location.startingLocationAccuracy {
                locationManager.desiredAccuracy = startingLocationAccuracy
            }
        }
    }
    
    func getPlacemarks() {
        view.startLoading()
        interactor.getData(success: { [weak self] (placemarks) in
            guard let strongSelf = self else { return }
            strongSelf.view.finishLoading()
            strongSelf.view.populateMap(withViewData: placemarks.map { strongSelf.getViewModel(forPlacemark: $0) })
        }, failure: { [weak self] (error) in
            self?.view.finishLoading()
            self?.view.showError(message: error.localizedDescription)
        })
    }

    func reloadData() {
        view.startLoading()
        interactor.loadDataFromNetwork(success: { [weak self] (placemarks) in
            guard let strongSelf = self else { return }
            strongSelf.view.finishLoading()
            strongSelf.view.populateMap(withViewData: placemarks.map { strongSelf.getViewModel(forPlacemark: $0) })
        }, failure: { [weak self] (error) in
            self?.view.finishLoading()
            self?.view.showError(message: error.localizedDescription)
        })
    }
}

// MARK: - CLLocationManagerDelegate
extension BaseMapViewPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        view.centerMap(center: location.coordinate, isAnimated: true)
        view.finishLoading()
    }

    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        view.finishLoading()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            view.showError(message: error.localizedDescription)
        }
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .restricted, .denied:
            view.showError(message: LocationError.userDeclined.localizedDescription)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

// MARK: - Helpers
extension BaseMapViewPresenter {
    private func getViewModel(forPlacemark placemark: Placemark) -> PlacemarkMapViewModel {
        return PlacemarkMapViewModel(address: placemark.address,
                                     coordinates: placemark.coordinates,
                                     engineType: placemark.engineType,
                                     exterior: placemark.exterior,
                                     fuel: placemark.fuel,
                                     interior: placemark.interior,
                                     name: placemark.name)
    }
}
