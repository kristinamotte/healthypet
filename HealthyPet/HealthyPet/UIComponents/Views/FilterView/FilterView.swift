//
//  FilterView.swift
//  HealthyPet
//
//  Created by Kristina Motte on 07.07.2022.
//

import UIKit

class FilterView: UIView {
    @IBOutlet weak var allButton: FilterButton!
    @IBOutlet weak var dogsButton: FilterButton!
    @IBOutlet weak var catsButton: FilterButton!
    
    @IBAction func didTapAllButton(_ sender: FilterButton) {
        if allButton.buttonStyle == .notPressed {
            allButton.buttonStyle = .pressed
            dogsButton.buttonStyle = .notPressed
            catsButton.buttonStyle = .notPressed
        }
    }
    
    @IBAction func didTapDogsButton(_ sender: FilterButton) {
        if dogsButton.buttonStyle == .notPressed {
            dogsButton.buttonStyle = .pressed
            allButton.buttonStyle = .notPressed
            catsButton.buttonStyle = .notPressed
        }
    }
    
    @IBAction func didTapCatsButton(_ sender: FilterButton) {
        if catsButton.buttonStyle == .notPressed {
            catsButton.buttonStyle = .pressed
            allButton.buttonStyle = .notPressed
            dogsButton.buttonStyle = .notPressed
        }
    }
}
