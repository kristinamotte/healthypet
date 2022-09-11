//
//  HealthyDropdown.swift
//  HealthyPet
//
//  Created by Kristina Motte on 11/09/2022.
//

import UIKit

class HealthyDropdown: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    var text: String {
        optionLabel.text ?? ""
    }
    
    func configure(with title: String, preselected option: String) {
        titleLabel.text = title
        optionLabel.text = option
    }
    
    func updatePreselected(option: String) {
        optionLabel.text = option
    }
    
    // MARK: - Private methods
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight12
        titleLabel.textColor = Theme.Colors.black
        optionLabel.font = Theme.Fonts.openSansLight12
        optionLabel.textColor = Theme.Colors.black
        
        containerView.layer.cornerRadius = Theme.Constants.cornerRadius
        containerView.layer.borderWidth = Theme.Constants.defaultBorderWidth
        containerView.layer.borderColor = Theme.Colors.mainGrey.cgColor
    }
}
