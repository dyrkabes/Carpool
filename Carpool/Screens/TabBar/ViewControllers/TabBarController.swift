//
//  TabBarController.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Injected
    private var interactor: MainInteractor!
    
    // MARK: - Public func
    func setInteractor(_ interactor: MainInteractor) {
        self.interactor = interactor
    }
}
