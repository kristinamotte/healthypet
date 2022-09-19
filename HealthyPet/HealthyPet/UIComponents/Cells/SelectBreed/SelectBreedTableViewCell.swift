//
//  SelectBreedTableViewCell.swift
//  HealthyPet
//
//  Created by Kristina Motte on 15/09/2022.
//

import UIKit

class SelectBreedTableViewCell: UITableViewCell, ReusableTableCell {
    // MARK: - Outlets
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        checkMarkImageView.isHidden = !selected
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private methods
    private func configureUI() {
        separatorView.backgroundColor = Theme.Colors.lightGrey
        titleLabel.font = Theme.Fonts.openSansLight16
        titleLabel.textColor = Theme.Colors.black
        checkMarkImageView.tintColor = Theme.Colors.rose
    }
}
