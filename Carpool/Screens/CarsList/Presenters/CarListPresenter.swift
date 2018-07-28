//
//  CarListPresenter.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

protocol CarListPresenter {
    init(view: CarListView, interactor: CarListInteractor)
    func getData()
    func getViewModelForRow(row: Int) -> PlacemarkListViewModel
    func getPlacemarksCount() -> Int
}
