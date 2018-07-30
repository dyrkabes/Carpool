//
//  SceneBuilder.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

fileprivate extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "TabBar", bundle: nil)
    }
    
    static var carList: UIStoryboard {
        return UIStoryboard(name: "CarList", bundle: nil)
    }
    
    static var map: UIStoryboard {
        return UIStoryboard(name: "Map", bundle: nil)
    }
}

enum SceneBuilder {
    static func createTabBar() -> TabBarController {
        guard let tabBarController = UIStoryboard.main.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else {
            fatalError("Tabbar cannot be initialized")
        }
        return tabBarController
    }
    
    static func createCarListViewController() -> CarListViewController {
        guard let carListVC = UIStoryboard.carList.instantiateInitialViewController() as? CarListViewController else {
            fatalError("Car list cannot be initialized")
        }
        return carListVC
    }
    
    static func createMapViewController() -> MapViewController {
        guard let mapViewController = UIStoryboard.map.instantiateInitialViewController() as? MapViewController else {
            fatalError("MapView cannot be initialized")
        }
        
        return mapViewController
    }
}
