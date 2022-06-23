//
//  TabBarCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let controller: TabBarViewController

    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = TabBarViewController()
    }

    func start() {
        presenter.pushViewController(controller, animated: true)
    }
}

