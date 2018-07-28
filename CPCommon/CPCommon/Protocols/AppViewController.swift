//
//  AppViewController.swift
//  CPCommon
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit

public protocol AppViewController: class {
    func startLoading()
    func finishLoading()
    func showError(error: Error)
}
