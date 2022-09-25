//
//  HomeEmptyViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit
import Lottie

class HomeEmptyViewController: UIViewController {
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        textLabel.font = Theme.Fonts.openSansLight16
        textLabel.textColor = Theme.Colors.textGrey
        animationView.play()
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
    }
}

extension HomeEmptyViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
