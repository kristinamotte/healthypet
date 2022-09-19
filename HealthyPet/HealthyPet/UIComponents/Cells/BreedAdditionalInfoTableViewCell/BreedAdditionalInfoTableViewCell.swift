//
//  BreedAdditionalInfoTableViewCell.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import UIKit

class BreedAdditionalInfoTableViewCell: UITableViewCell, ReusableTableCell {
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        configureUI()
    }
    
    func configure(with title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    // MARK: - Private methods
    private func configureUI() {
        containerView.layer.cornerRadius = Theme.Constants.cornerRadius
        containerView.backgroundColor = .clear
        containerView.layer.borderWidth = Theme.Constants.defaultBorderWidth
        containerView.layer.borderColor = Theme.Colors.mainGrey.cgColor
        titleContainerView.backgroundColor = Theme.Colors.greyBg
        titleLabel.font = Theme.Fonts.openSansBold14
        descriptionLabel.font = Theme.Fonts.openSansRegular14
        descriptionLabel.textColor = Theme.Colors.textGrey
    }
}
