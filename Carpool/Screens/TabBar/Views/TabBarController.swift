//
//  TabBarController.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import CPCommon

final class TabBarController: UITabBarController, UITabBarControllerDelegate, Identifiable {
    // MARK: - Injected
    private var interactor: AppDataWorker!
    
    // MARK: - View lifecycle
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onEnterForeground),
                                               name: .UIApplicationWillEnterForeground, object: nil)
    }

    @objc func onEnterForeground() {
        interactor.loadDataFromNetwork(success: { _ in }, failure: { _ in })
    }
}
