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
    private let parentInteractor: MainInteractor
    
    // MARK: - Init
    init(parentInteractor interactor: MainInteractor) {
        self.parentInteractor = interactor
    }
    
    // MARK: - Public
    func start() -> UIViewController {
        let mapViewController = SceneBuilder.createMapViewController()
        
        let interactor = BaseMapViewInteractor(parentInteractor: parentInteractor)
        let presenter = BaseMapViewPresenter(view: mapViewController, interactor: interactor)
        mapViewController.setPresenter(presenter)
        
        mapViewController.tabBarItem = UITabBarItem(title: AppTexts.map, image: AppImages.map, tag: 1)
        
        return mapViewController
    }
}
