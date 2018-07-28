//
//  CarListView.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

protocol CarListView: AppViewController {
    func setPresenter(_ presenter: CarListPresenter)
    func reloadData()
}
