//
//  AppDelegate.swift
//  Carpool
//
//  Created by Pavel Stepanov on 27/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        instantiateWindow()
        return true
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
