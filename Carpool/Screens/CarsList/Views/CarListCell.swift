//
//  CarListCell.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import CPCommon

final class CarListCell: UITableViewCell, Identifiable {
    // MARK: - Outlets
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var interiorLabel: UILabel!
    @IBOutlet weak var exteriorLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    
    // MARK: - Public func
    func setup(withViewModel viewModel: PlacemarkListViewModel) {
        backgroundColor = .clear
        nameLabel.text = viewModel.name
        interiorLabel.text = viewModel.interior.description
        exteriorLabel.text = viewModel.exterior.description
        addressLabel.text = viewModel.address
        engineLabel.text = viewModel.engineType
        fuelLabel.text = "\(viewModel.fuel)"
        
        innerContentView.setupCardShadow()
    }
}
