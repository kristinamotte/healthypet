//
//  HomeEmptyViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit
import Lottie

class HomeEmptyViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Type
    var type: HomeEmptyType = .loading
    
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
        animationView.isHidden = type.isAnimationViewHidden
        petImageView.isHidden = type.isImageHidden
        textLabel.text = type.text
    }
}

extension HomeEmptyViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
