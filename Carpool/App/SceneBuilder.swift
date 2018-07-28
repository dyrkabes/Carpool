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
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static var carList: UIStoryboard {
        return UIStoryboard(name: "CarList", bundle: nil)
    }
    
    static var map: UIStoryboard {
        return UIStoryboard(name: "Map", bundle: nil)
    }
}

enum SceneBuilder {
    static func createTabBar() -> UITabBarController {
        return UIStoryboard.main.instantiateInitialViewController() as! UITabBarController
    }
    
    static func createCarListViewController() -> UIViewController {
        return UIStoryboard.main.instantiateInitialViewController()!
    }
    
    static func createMapViewController() -> UIViewController {
        return UIStoryboard.main.instantiateInitialViewController()!
    }
}
