//
//  BaseCarListPresenter.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation
import CPCommon

class BaseCarListPresenter: CarListPresenter {
    // MARK: - Injected
    private var interactor: CarListInteractor
    private unowned var view: CarListView
    
    // MARK: - Init
    required init(view: CarListView, interactor: CarListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - Public func
    func getPlacemarks() {
        view.startLoading()
        
        interactor.getData(success: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.view.finishLoading()
            strongSelf.view.reloadData()
        }) { [weak self] (error) in
            self?.view.finishLoading()
            self?.view.showError(error: error)
        }
    }
    
    func reloadData() {
        view.startLoading()
        
        interactor.reloadData(success: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.view.finishLoading()
            strongSelf.view.reloadData()
        }) { [weak self] (error) in
            self?.view.finishLoading()
            self?.view.showError(error: error)
        }
    }
    
    func getViewModelForRow(row: Int) -> PlacemarkListViewModel {
        guard let placemark = interactor.getPlacemarks()[try: row] else {
            print(" **** Error: could not retrive placemark \(self.self) \(#line)")
            return PlacemarkListViewModel.empty
        }
        
        return getPlacemarkListViewModel(fromPlacemark: placemark)
    }
    
    func getPlacemarksCount() -> Int {
        return interactor.getPlacemarks().count
    }
}

// MARK: - Helpers 
extension BaseCarListPresenter {
    private func getPlacemarkListViewModel(fromPlacemark placemark: Placemark) -> PlacemarkListViewModel {
        return PlacemarkListViewModel(address: placemark.address,
                                      engineType: placemark.engineType,
                                      exterior: placemark.exterior,
                                      fuel: placemark.fuel,
                                      interior: placemark.interior,
                                      name: placemark.name)
    }
}


