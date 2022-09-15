//
//  SelectedOptionCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 15/09/2022.
//

import UIKit

class SelectOptionCoordinator: Coordinator {
    // MARK: - Dependencies
    let presenter: UIViewController
    let controller: SelectOptionViewController
    let breeds: [String]
    let selectedOption: String
    
    init(presenter: UIViewController, breeds: [String], selectedOption: String, delegate: SelectOptionViewControllerDelegate?) {
        self.presenter = presenter
        self.breeds = breeds
        self.selectedOption = selectedOption
        controller = SelectOptionViewController.fromStoryboard
        controller.delegate = delegate
    }
    
    func start() {
        controller.viewModel = viewModel
        presenter.present(controller, animated: true)
    }
    
    var viewModel: SelectOptionViewModel {
        let viewModel = SelectOptionViewModel(breeds: breeds, selectedOption: selectedOption)
        
        return viewModel
    }
}
