//
//  TabBarController.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Injected
    private var interactor: AppDataWorker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToEnterForeground()
    }
    
    // MARK: - Public func
    func setInteractor(_ interactor: AppDataWorker) {
        self.interactor = interactor
    }
    
    // MARK: - Subscriptions
    fileprivate func subscribeToEnterForeground() {
        NotificationCenter.default.addObserver(self, selector: #selector(onEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func onEnterForeground() {
        interactor.loadDataFromNetwork(success: { _ in }, failure: { _ in })
    }
}
