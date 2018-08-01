//
//  BaseTabBarInteractor.swift
//  Carpool
//
//  Created by Pavel Stepanov on 28/07/2018.
//  Copyright © 2018 Pavel Stepanov. All rights reserved.
//

import Foundation

final class AppMainInteractor: AppDataWorker {
    // MARK: - Injected
    private var networkWorker: PlacemarksNetworkWorker
    private var storageWorker: PersistentStorageWorker
    
    // MARK: - Instance properties
    fileprivate var state: MainInteractorState = .hasNotLoaded
    fileprivate var requestHandlers: [PlacemarkHandlerWrapper] = []

    // MARK: - Init
    init(networkWorker: PlacemarksNetworkWorker, storageWorker: PersistentStorageWorker) {
        self.networkWorker = networkWorker
        self.storageWorker = storageWorker
    }

    // MARK: - Public func
    func loadDataFromNetwork(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        guard state != .isLoading else {
            let hanlderWrapper = PlacemarkHandlerWrapper(success: success, failure: failure)   // code duplication
            requestHandlers.append(hanlderWrapper)
            return
        }

        state = .isLoading
        networkWorker.loadPlacemarks(success: { [weak self] (placemarks) in
            guard let strongSelf = self else { return }
            strongSelf.state = .hasLoaded
            DispatchQueue.main.async {
                strongSelf.savePlacemarks(placemarks)
                strongSelf.requestHandlers.forEach { $0.success(placemarks) }
                success(placemarks)
            }
            }, failure: { [weak self] error in
                DispatchQueue.main.async {
                    self?.requestHandlers.forEach { $0.failure(error) }
                    failure(error)
                }
        })
    }

    func getData(success: @escaping PlacemarksSuccessHandler, failure: @escaping ErrorHandler) {
        switch state {
        case .hasNotLoaded:
            loadDataFromNetwork(success: success, failure: failure)
        case .isLoading:
            let hanlderWrapper = PlacemarkHandlerWrapper(success: success, failure: failure)
            requestHandlers.append(hanlderWrapper)
        case .hasLoaded:
            success(storageWorker.getPlacemarks())
        }
    }
}

// MARK: - Helper functions
extension AppMainInteractor {
    private func savePlacemarks(_ placemarks: [Placemark]) {
        do {
            try storageWorker.writePlacemarks(placemarks)
        } catch {
            print("**** Error saving to persistent storage")
        }
    }
}
