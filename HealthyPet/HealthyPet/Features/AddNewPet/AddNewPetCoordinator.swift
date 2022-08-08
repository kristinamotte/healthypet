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
        presenter.setNavigationBarHidden(true, animated: false)
        presenter.pushViewController(controller, animated: true)
    }
}
