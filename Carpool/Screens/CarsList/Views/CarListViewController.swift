//
//  FirstViewController.swift
//  Carpool
//
//  Created by Pavel Stepanov on 27/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import UIKit
import MapKit
import CPCommon

/**
 - Note:
 If the logic in the UITableViewDataSource and UITableViewDelegate extension was more complex I would move it to presenter.
 */
final class CarListViewController: BaseViewController, CarListView {
    // MARK: - Injected
    private var presenter: CarListPresenter!
    
    // MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        subscribeToEnterForeground()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribe()
    }
    
    // MARK: - Public func
    func setPresenter(_ presenter: CarListPresenter) {
        self.presenter = presenter
    }
    
    override func startLoading() {
        refreshControl.beginRefreshing()
    }
    
    override func finishLoading() {
        refreshControl.endRefreshing()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    @objc private func getData() {
        presenter.getPlacemarks()
    }
    
    // MARK: - Actions
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.reloadData()
    }
    
    // MARK: - Subscriptions
    private func subscribeToEnterForeground() {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    private func unsubscribe() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CarListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPlacemarksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListCell.identifier, for: indexPath) as? CarListCell else {
            print(" **** Error: Could not dequeue table view cell. That's shame \(#function) \(#line)")
            return UITableViewCell()
        }
        
        cell.setup(withViewModel: presenter.getViewModelForRow(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UI Helpers
extension CarListViewController {
    private func setupView() {
        let nib = UINib(nibName: CarListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CarListCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.refreshControl = refreshControl
        
        title = AppTexts.list
    }
}

private enum Constants {
    static let estimatedRowHeight: CGFloat = 120.0
}
