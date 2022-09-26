//
//  DocumentPreviewCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit

class DocumentPreviewCoordinator: Coordinator {
    // MARK: - Dependencies
    let presenter: UINavigationController
    let controller: DocumentPreviewViewController
    let url: URL
    
    init(presenter: UINavigationController, url: URL) {
        self.url = url
        self.presenter = presenter
        controller = DocumentPreviewViewController.fromStoryboard
    }
    
    func start() {
        controller.viewModel = viewModel
        controller.hidesBottomBarWhenPushed = true
        controller.modalPresentationStyle = .fullScreen
        presenter.pushViewController(controller, animated: true)
    }
    
    var viewModel: DocumentPreviewViewModel {
        let viewModel = DocumentPreviewViewModel(url: url)
        
        viewModel.onPreviousScreen = { [presenter] in
            presenter.popViewController(animated: true)
        }
        
        viewModel.onSaveFile = { [presenter] files in
            // Make the activityViewContoller which shows the share-view
            let activityViewController = UIActivityViewController(activityItems: files, applicationActivities: nil)

            // Show the share-view
            presenter.present(activityViewController, animated: true, completion: nil)
        }
        
        return viewModel
    }
}
