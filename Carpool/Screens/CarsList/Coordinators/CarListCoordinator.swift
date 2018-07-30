//
//  CarListCoordinator.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import CPCommon

struct CarListCoordinator: Coordinator {
    private let parentInteractor: AppDataWorker
    
    init(parentInteractor interactor: AppDataWorker) {
        self.parentInteractor = interactor
    }
    
    func start() -> UIViewController {
        let carListViewController = SceneBuilder.createCarListViewController()
        carListViewController.title = AppTexts.list
        
        let carListInteractor = BaseCarListInteractor(parentInteractor: parentInteractor)
        let carListPresenter = BaseCarListPresenter(view: carListViewController, interactor: carListInteractor)
        carListViewController.setPresenter(carListPresenter)
        
        let navigationController = UINavigationController(rootViewController: carListViewController)
        
        navigationController.tabBarItem = UITabBarItem(title: AppTexts.list, image: AppImages.carList, tag: 0)
        
        return navigationController
    }
}
