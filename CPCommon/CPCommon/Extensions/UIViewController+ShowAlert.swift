//
//  UIViewController+ShowAlert.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 02/08/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String? = AppTexts.appName,
                   message: String,
                   handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AppTexts.ok, style: .default) { action in
            handler?()
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
