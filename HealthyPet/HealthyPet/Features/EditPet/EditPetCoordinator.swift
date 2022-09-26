//
//  EditPetCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit

class EditPetCoordinator: NSObject, Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: EditPetViewController
    var animal: Animal
    var url: URL?
    
    init(presenter: UINavigationController, animal: Animal, url: URL?, delegate: EditPetViewControllerDelegate?) {
        self.presenter = presenter
        self.animal = animal
        self.url = url
        controller = EditPetViewController.fromStoryboard
        controller.delegate = delegate
    }
    
    func start() {
        controller.viewModel = viewModel
        presenter.setNavigationBarHidden(true, animated: false)
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: EditPetViewModel {
        let viewModel = EditPetViewModel(animal: animal, url: url, delegate: controller)
        
        viewModel.onSelectBreeds = { [controller] breeds, selectedOption in
            SelectOptionCoordinator(presenter: controller, breeds: breeds, selectedOption: selectedOption, delegate: controller).start()
        }
        
        viewModel.onPreviousScreen = { [presenter] in
            presenter.popViewController(animated: true)
        }
        
        return viewModel
    }
}
