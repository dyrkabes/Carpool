//
//  AppCoordinator.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import CPCommon

/// Configuares the main screen.
struct AppCoordinator: Coordinator {
    func start() -> UIViewController {
        // MARK: - TabBar
        let tabBar = SceneBuilder.createTabBar()
        
        let networker = LocalPlacemarksNetworkWorker(placemarksData: StubDataProvider.locations.data)
        let storageWorker = InMemoryStorage()
        // TODO: Persist in core data
//            CoreDataPersistentStorageWorker()
        
        let tabBarInteractor = AppMainInteractor(networkWorker: networker, storageWorker: storageWorker)
        tabBar.setInteractor(tabBarInteractor)
        
        
        // MARK: - CarList
        let carListCoordinator = CarListCoordinator(parentInteractor: tabBarInteractor)
        let carListViewController = carListCoordinator.start()
        
        // MARK: - Map
        let mapCoordinator = MapCoordinator(parentInteractor: tabBarInteractor)
        let mapViewController = mapCoordinator.start()
        
        
        tabBar.viewControllers = [carListViewController, mapViewController]
        
        return tabBar
    }
}
