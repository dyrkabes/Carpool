//
//  AppCoordinator.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import CPCommon

struct AppCoordinator: Coordinator {
    func start() -> UIViewController {
        // MARK: - TabBar
        let tabBar = SceneBuilder.createTabBar()
        
        let networker = StubbedPlacemarksNetworkWorker()
        let storageWorker = CoreDataPersistentStorageWorker()
        
        let tabBarInteractor = BaseMainInteractor(networkWorker: networker, storageWorker: storageWorker)
        tabBar.setInteractor(tabBarInteractor)
        
        
        // MARK: - CarList
        let carListCoordinator = CarListCoordinator(parentInteractor: tabBarInteractor)
        let carListViewController: UIViewController = carListCoordinator.start()
        carListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        
        // MARK: - Map
        // TODO: Map coordinator
        let mapViewController = SceneBuilder.createMapViewController()
        mapViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        
        tabBar.viewControllers = [carListViewController, mapViewController]
        
        return tabBar
    }
}
