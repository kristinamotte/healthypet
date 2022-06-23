//
//  CoordinatorDelegate.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func switchTab(with item: TabBarItem)
    var tabBarNavigation: UINavigationController? { get }
}
