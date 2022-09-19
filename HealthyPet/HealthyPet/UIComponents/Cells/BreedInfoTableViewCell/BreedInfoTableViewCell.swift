//
//  BreedInfoTableViewCell.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import UIKit

class BreedInfoTableViewCell: UITableViewCell, ReusableTableCell {
    // MARK: - Outlets
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var locationStackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configure(with name: String, location: String?, url: URL?) {
        nameLabel.text = name
        
        if let location = location, !location.isEmpty {
            locationLabel.text = location
            locationStackView.isHidden = false
        } else {
            locationStackView.isHidden = true
        }
        
        if let url = url {
            photoContainerView.isHidden = false
            indicatorView.startAnimating()
            
            breedImageView.loadImage(at: url, placeholder: nil) {
                self.indicatorView.stopAnimating()
            }
        } else {
            photoContainerView.isHidden = true
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        nameLabel.font = Theme.Fonts.openSansBold20
        locationLabel.font = Theme.Fonts.openSansRegular12
        locationLabel.textColor = Theme.Colors.textGrey
        separatorView.backgroundColor = Theme.Colors.separatorGrey
    }
}
