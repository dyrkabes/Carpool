//
//  MapCoordinator.swift
//  Carpool
//
//  Created by Pavel Stepanov on 29/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

/// Creates map module.
struct MapCoordinator: Coordinator {
    // MARK: - Injected
    private let parentInteractor: AppDataWorker
    
    // MARK: - Init
    init(parentInteractor interactor: AppDataWorker) {
        self.parentInteractor = interactor
    }
    
    // MARK: - Public
    func start() -> UIViewController {
        let mapViewController = SceneBuilder.createMapViewController()
        mapViewController.title = AppTexts.map
        
        let interactor = BaseMapViewInteractor(parentInteractor: parentInteractor)
        let presenter = BaseMapViewPresenter(view: mapViewController, interactor: interactor)
        mapViewController.setPresenter(presenter)
        
        let navigationController = UINavigationController(rootViewController: mapViewController)
        
        navigationController.tabBarItem = UITabBarItem(title: AppTexts.map, image: AppImages.map, tag: 1)
        
        return navigationController
    }
}
