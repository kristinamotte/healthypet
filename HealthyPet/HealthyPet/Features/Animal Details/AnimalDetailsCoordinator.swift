//
//  AnimalDetailsCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit

class AnimalDetailsCoordinator: Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: AnimalDetailsViewController
    let animal: Animal
    let animalImageUrl: URL?
    
    init(presenter: UINavigationController, animal: Animal, animalImageUrl: URL?) {
        self.animal = animal
        self.animalImageUrl = animalImageUrl
        self.presenter = presenter
        controller = AnimalDetailsViewController.fromStoryboard
    }
    
    func start() {
        controller.viewModel = viewModel
        controller.hidesBottomBarWhenPushed = true
        controller.modalPresentationStyle = .fullScreen
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: AnimalDetailsViewModel {
        let viewModel = AnimalDetailsViewModel(animal: animal, animalImageUrl: animalImageUrl)
        
        viewModel.onPreviosScreen = { [presenter] in
            presenter.popViewController(animated: true)
        }
        
        viewModel.onGeneratedPdf = { [presenter] url in
            DocumentPreviewCoordinator(presenter: presenter, url: url).start()
        }
        
        return viewModel
    }
}
