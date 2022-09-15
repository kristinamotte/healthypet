//
//  SelectedOptionViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 15/09/2022.
//

import Foundation

class SelectOptionViewModel {
    let breeds: [String]
    var selectedOption: String
    
    init(breeds: [String], selectedOption: String) {
        self.breeds = breeds
        self.selectedOption = selectedOption
    }
}
