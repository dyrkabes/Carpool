//
//  CarListCoordinator.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

/// Creates car list module.
struct CarListCoordinator: Coordinator {
    // MARK: - Injected
    private let parentInteractor: AppDataWorker
    
    // MARK: - Init
    init(parentInteractor interactor: AppDataWorker) {
        self.parentInteractor = interactor
    }
    
    // MARK: - Public func
    func start() -> UIViewController {
        let carListViewController = SceneBuilder.createCarListViewController()
        
        let carListInteractor = BaseCarListInteractor(parentInteractor: parentInteractor)
        let carListPresenter = BaseCarListPresenter(view: carListViewController, interactor: carListInteractor)
        carListViewController.setPresenter(carListPresenter)
        
        let navigationController = UINavigationController(rootViewController: carListViewController)
        
        navigationController.tabBarItem = UITabBarItem(title: AppTexts.list, image: AppImages.carList, tag: 0)
        
        return navigationController
    }
}
