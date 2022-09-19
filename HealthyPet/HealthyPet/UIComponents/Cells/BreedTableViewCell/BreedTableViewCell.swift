//
//  BreedTableViewCell.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import UIKit

class BreedTableViewCell: UITableViewCell, ReusableTableCell {
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var originStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configure(with breed: GeneralBreed) {
        breedNameLabel.text = breed.name
        
        if let description = breed.description, !description.isEmpty {
            descriptionLabel.text = description
            descriptionLabel.isHidden = false
        } else {
            descriptionLabel.isHidden = true
        }
        
        if let origin = breed.origin, !origin.isEmpty {
            originLabel.text = origin
            originStackView.isHidden = false
        } else {
            originStackView.isHidden = true
        }
    }

    // MARK: - Private methods
    private func configureUI() {
        containerView.layer.cornerRadius = Theme.Constants.cornerRadius
        containerView.layer.borderWidth = Theme.Constants.defaultBorderWidth
        containerView.layer.borderColor = Theme.Colors.mainGrey.cgColor
        breedNameLabel.font = Theme.Fonts.openSansBold14
        descriptionLabel.font = Theme.Fonts.openSansRegular12
        descriptionLabel.textColor = Theme.Colors.textGrey
        originLabel.font = Theme.Fonts.openSansRegular12
        originLabel.textColor = Theme.Colors.textGrey
    }
}
