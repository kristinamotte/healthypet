//
//  AddNewPetCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 08/08/2022.
//

import UIKit

class AddNewPetCoordinator: NSObject, Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: AddNewPetViewController
    weak var delegate: CoordinatorDelegate?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        controller = AddNewPetViewController.fromStoryboard
        super.init()
    }
    
    func start() {
        controller.viewModel = viewModel
        presenter.setNavigationBarHidden(true, animated: false)
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: AddNewPetViewModel {
        let viewModel = AddNewPetViewModel(delegate: controller)
        
        return viewModel
    }
}
