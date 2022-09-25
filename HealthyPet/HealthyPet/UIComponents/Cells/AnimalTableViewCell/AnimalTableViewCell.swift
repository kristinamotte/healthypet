//
//  AnimalTableViewCell.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit

class AnimalTableViewCell: UITableViewCell, ReusableTableCell {
    // MARK: - Outlets
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var breedContainerView: UIView!
    @IBOutlet weak var photoLoader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        imageContainerView.layer.cornerRadius = Theme.Constants.cornerRadius
        breedContainerView.layer.cornerRadius = Theme.Constants.cornerRadius
        containerView.layer.cornerRadius = Theme.Constants.cornerRadius
        nameLabel.font = Theme.Fonts.openSansBold16
        nameLabel.textColor = Theme.Colors.black
        ageLabel.font = Theme.Fonts.openSansRegular12
        ageLabel.textColor = Theme.Colors.textGrey
        separatorView.layer.cornerRadius = separatorView.bounds.height
        breedLabel.font = Theme.Fonts.openSansRegular12
        breedLabel.textColor = Theme.Colors.textGrey
    }
}
