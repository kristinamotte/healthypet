//
//  BreedDetailsCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import UIKit

class BreedDetailsCoordinator: Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: BreedDetailsViewController
    let breed: GeneralBreed
    
    init(presenter: UINavigationController, breed: GeneralBreed) {
        self.breed = breed
        self.presenter = presenter
        controller = BreedDetailsViewController.fromStoryboard
    }
    
    func start() {
        controller.viewModel = viewModel
        controller.hidesBottomBarWhenPushed = true
        controller.modalPresentationStyle = .fullScreen
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: BreedDetailsViewModel {
        let viewModel = BreedDetailsViewModel(breed: breed)
        
        viewModel.onPreviosScreen = { [presenter] in
            presenter.popViewController(animated: true)
        }
        
        return viewModel
    }
}
