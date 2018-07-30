//
//  BaseViewController.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import MBProgressHUD

open class BaseViewController: UIViewController, AppViewController {
    open func startLoading() {
        let progressHUD = MBProgressHUD.showAdded(to: destinationView(withNavBar: true), animated: true)
        progressHUD.isUserInteractionEnabled = false
    }
    
    open func finishLoading() {
        MBProgressHUD.hide(for: destinationView(withNavBar: true), animated: false)
    }
    
    public func showError(error: Error) {
        // TODO: Implement
    }
    
    fileprivate func destinationView(withNavBar navBar: Bool) -> UIView {
        if navBar, let navigationControllerView = navigationController?.view {
            return navigationControllerView
        } else {
            return view
        }
    }
}
