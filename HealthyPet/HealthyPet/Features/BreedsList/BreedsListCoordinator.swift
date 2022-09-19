//
//  BreedsListCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import UIKit

class BreedsListCoordinator: NSObject, Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: BreedsListViewController
    weak var delegate: CoordinatorDelegate?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        controller = BreedsListViewController.fromStoryboard
        super.init()
    }
    
    func start() {
        controller.viewModel = viewModel
        presenter.setNavigationBarHidden(true, animated: false)
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: BreedsListViewModel {
        let viewModel = BreedsListViewModel()

        return viewModel
    }
}
