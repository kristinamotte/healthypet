//
//  AnimalDetailsViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit

class AnimalDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petGenderImageView: UIImageView!
    @IBOutlet weak var breedSeparatorView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ownerContainerView: UIView!
    @IBOutlet weak var ownerInfoTitleLabel: UILabel!
    @IBOutlet weak var ownerSeparatorView: UIView!
    @IBOutlet weak var ownerNumberLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var generatePdfButton: UIButton!
    
    // MARK: - View Model
    var viewModel: AnimalDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureContent()
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
    }
    
    // MARK: - Private methods
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        petNameLabel.font = Theme.Fonts.openSansBold24
        petBreedLabel.font = Theme.Fonts.openSansRegular12
        petBreedLabel.textColor = Theme.Colors.textGrey
        ageLabel.font = Theme.Fonts.openSansRegular12
        ageLabel.textColor = Theme.Colors.textGrey
        breedSeparatorView.layer.cornerRadius = breedSeparatorView.bounds.height / 2
        breedSeparatorView.backgroundColor = Theme.Colors.blue
        ownerContainerView.layer.cornerRadius = Theme.Constants.cornerRadius
        ownerContainerView.backgroundColor = Theme.Colors.greyBg
        ownerInfoTitleLabel.font = Theme.Fonts.openSansBold14
        ownerSeparatorView.backgroundColor = Theme.Colors.mainGrey
        ownerNameLabel.font = Theme.Fonts.openSansRegular12
        ownerNameLabel.textColor = Theme.Colors.textGrey
        ownerNumberLabel.font = Theme.Fonts.openSansBold12
        ownerNumberLabel.textColor = Theme.Colors.blue
        generatePdfButton.backgroundColor = .clear
        generatePdfButton.layer.borderWidth = Theme.Constants.defaultBorderWidth
        generatePdfButton.layer.borderColor = Theme.Colors.rose.cgColor
        generatePdfButton.titleLabel?.font = Theme.Fonts.openSansRegular12
        generatePdfButton.setTitleColor(Theme.Colors.black, for: .normal)
        generatePdfButton.layer.cornerRadius = generatePdfButton.bounds.height / 2
        generatePdfButton.setImage(#imageLiteral(resourceName: "ic_pdf"), for: .normal)
    }
    
    private func configureContent() {
        guard let viewModel = viewModel else { return }
        
        petNameLabel.text = viewModel.animal.petName
        petBreedLabel.text = viewModel.animal.breed
        petGenderImageView.image = viewModel.animal.genderIcon
        ageLabel.text = viewModel.animal.age
        ownerNumberLabel.text = viewModel.animal.ownerNumber
        ownerNameLabel.text = viewModel.animal.ownerName
        
        if let url = viewModel.animalImageUrl {
            petImageView.isHidden = false
            petImageView.loadImage(at: url, placeholder: nil) {
                
            }
        } else {
            petImageView.isHidden = true
        }
    }
    
    @objc private func didTapBackButton() {
        viewModel?.onPreviosScreen?()
    }
    
    @IBAction private func didTapGeneratePdfButton(_ sender: UIButton) {
    }
}

extension AnimalDetailsViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
