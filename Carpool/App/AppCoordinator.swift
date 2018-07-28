//
//  AppCoordinator.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

struct AppCoordinator {
    func start() -> UIViewController {
        let tabBar = SceneBuilder.createTabBar()
        
        let carListViewController = SceneBuilder.createCarListViewController()
        let mapViewController = SceneBuilder.createMapViewController()
        
        tabBar.viewControllers = [carListViewController, mapViewController]
        
        return tabBar
    }
}
