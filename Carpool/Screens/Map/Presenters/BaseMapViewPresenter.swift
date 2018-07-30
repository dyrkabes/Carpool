//
//  BaseMapViewPresenter.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

final class BaseMapViewPresenter: MapViewPresenter {
    // MARK: - Injected
    private unowned var view: MapView
    private var interactor: MapViewInteractor
    
    // MARK: - Init
    required init(view: MapView, interactor: MapViewInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - Public func
    func getPlacemarks() {
        view.startLoading()
        interactor.getData(success: { [weak self] (placemarks) in
            guard let strongSelf = self else { return }
            strongSelf.view.finishLoading()
            strongSelf.view.populateMap(withViewData: placemarks.map { strongSelf.getViewModel(forPlacemark: $0) })
        }) { [weak self] (error) in
            self?.view.finishLoading()
            self?.view.showError(error: error)
        }
    }
    
    func reloadData() {
        interactor.loadDataFromNetwork(success: { [weak self] (placemarks) in
            guard let strongSelf = self else { return }
            strongSelf.view.finishLoading()
            strongSelf.view.populateMap(withViewData: placemarks.map { strongSelf.getViewModel(forPlacemark: $0) })
        }) { [weak self] (error) in
            self?.view.finishLoading()
            self?.view.showError(error: error)
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
