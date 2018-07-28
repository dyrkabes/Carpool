//
//  BaseViewController.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, AppViewController {
    public func startLoading() {
        print("Start loading")
    }
    
    public func finishLoading() {
        print("End loading")
    }
    
    public func showError(error: Error) {
        
    }
}

extension BaseViewController {
//    public func startLoading() {
//        //
//    }
//    
//    public func finishLoading() {
//        //
//    }
//    
//    public func showError(error: Error) {
//        
//    }
}
