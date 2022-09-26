//
//  HomeCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

class HomeCoordinator: NSObject, Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: HomeViewController
    weak var delegate: CoordinatorDelegate?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        controller = HomeViewController.fromStoryboard
        super.init()
    }
    
    func start() {
        controller.viewModel = viewModel
        presenter.setNavigationBarHidden(true, animated: false)
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: HomeViewModel {
        let viewModel = HomeViewModel(delegate: controller)
        
        viewModel.onAnimalDetails = { [presenter] animal, url in
            AnimalDetailsCoordinator(presenter: presenter, animal: animal, animalImageUrl: url).start()
        }
        
        return viewModel
    }
}
