//
//  SearchView.swift
//  HealthyPet
//
//  Created by Kristina Motte on 06.07.2022.
//

import UIKit

class SearchView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var filterContainerView: UIView!
    
    private var filterView: FilterView = FilterView.instanceFromNib()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        filterContainerView.add(subview: filterView)
    }
}
