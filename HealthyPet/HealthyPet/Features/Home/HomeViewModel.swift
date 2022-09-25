//
//  HomeViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func show(error: Error)
}

class HomeViewModel {
    private let dataUpdater: HomeDataUpdater
    
    weak var delegate: HomeViewModelDelegate?
    
    init(dataUpdater: HomeDataUpdater = HomeDataUpdaterImpl(), delegate: HomeViewModelDelegate?) {
        self.dataUpdater = dataUpdater
        self.delegate = delegate
    }
    
    func updateAllData(completion: @escaping (_ updated: Bool) -> Void) {
        if !DataSource.timedOut.isEmpty {
            dataUpdater.updateAllData { error in
                if let error = error {
                    self.delegate?.show(error: error)
                }
                
                completion(true)
            }
        } else {
            completion(false)
        }
    }
}
