//
//  ApplicationCoordinator.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    var presenter: UINavigationController = UINavigationController()
    var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        presenter.setNavigationBarHidden(true, animated: false)
        presenter.interactivePopGestureRecognizer?.delegate = nil
        window.rootViewController = presenter
        window.makeKeyAndVisible()

        let tabBarCoordinator = TabBarCoordinator(presenter: presenter)
        self.tabBarCoordinator = tabBarCoordinator

        tabBarCoordinator.start()
    }
}
