//
//  SearchView.swift
//  HealthyPet
//
//  Created by Kristina Motte on 06.07.2022.
//

import UIKit

class SearchView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var findPetContainerView: UIView!
    @IBOutlet weak var findPetStackView: UIStackView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var crossImageView: UIImageView!
    
    private var filterView: FilterView = FilterView.instanceFromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchContainerView.isHidden = true
        findPetContainerView.isHidden = false
        filterContainerView.add(subview: filterView)
        searchImageView.isUserInteractionEnabled = true
        crossImageView.isUserInteractionEnabled = true
        searchImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSearch)))
        crossImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseSearch)))
    }
    
    @objc private func didTapSearch() {
        searchContainerView.alpha = 1
        findPetContainerView.alpha = 0
        UIView.animate(withDuration: Theme.Constants.defaultAnimationDuration, delay: 0.0, options: .curveEaseInOut) {
            self.searchContainerView.isHidden = false
            self.findPetContainerView.isHidden = true
        }
    }
    
    @objc private func didTapCloseSearch() {
        searchContainerView.alpha = 0
        findPetContainerView.alpha = 1
        UIView.animate(withDuration: Theme.Constants.defaultAnimationDuration, delay: 0.0, options: .curveEaseInOut) {
            self.searchContainerView.isHidden = true
            self.findPetContainerView.isHidden = false
        }
    }
}
