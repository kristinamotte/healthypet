//
//  StoryboardController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

/// Protocol to instantiate UIViewController from storyboard
protocol StoryboardController where Self: UIViewController {
    static var fromStoryboard: Self { get }
    static var identifier: String { get }
    static var storyboard: Storyboard { get }
}

extension StoryboardController {
    static var fromStoryboard: Self {
        guard let viewController = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Failed to instantiate \(identifier)")
        }
        return viewController
    }

    static var identifier: String {
        return String(describing: self)
    }
}
