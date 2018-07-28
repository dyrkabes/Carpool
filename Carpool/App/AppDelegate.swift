//
//  AppDelegate.swift
//  Carpool
//
//  Created by Pavel Stepanov on 27/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        instantiateWindow()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
}

private extension AppDelegate {
    func instantiateWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = AppCoordinator()
        
        self.window?.rootViewController = appCoordinator.start()
        self.window?.makeKeyAndVisible()
    }
}
