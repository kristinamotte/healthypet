//
//  FilterView.swift
//  HealthyPet
//
//  Created by Kristina Motte on 07.07.2022.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func didSelect(option: FilterType)
}

class FilterView: UIView {
    @IBOutlet weak var allButton: FilterButton!
    @IBOutlet weak var dogsButton: FilterButton!
    @IBOutlet weak var catsButton: FilterButton!
    
    weak var delegate: FilterViewDelegate?
    
    // MARK: - Life cycle
    class func loadFromNib(delegate: FilterViewDelegate? = nil) -> FilterView {
        let view = Bundle.main.loadNibNamed("FilterView", owner: nil, options: nil)?.first as! FilterView
        view.delegate = delegate
        return view
    }
    
    @IBAction func didTapAllButton(_ sender: FilterButton) {
        if allButton.buttonStyle == .notPressed {
            delegate?.didSelect(option: .all)
            allButton.buttonStyle = .pressed
            dogsButton.buttonStyle = .notPressed
            catsButton.buttonStyle = .notPressed
        }
    }
    
    @IBAction func didTapDogsButton(_ sender: FilterButton) {
        if dogsButton.buttonStyle == .notPressed {
            delegate?.didSelect(option: .dogs)
            dogsButton.buttonStyle = .pressed
            allButton.buttonStyle = .notPressed
            catsButton.buttonStyle = .notPressed
        }
    }
    
    @IBAction func didTapCatsButton(_ sender: FilterButton) {
        if catsButton.buttonStyle == .notPressed {
            delegate?.didSelect(option: .cats)
            catsButton.buttonStyle = .pressed
            allButton.buttonStyle = .notPressed
            dogsButton.buttonStyle = .notPressed
        }
    }
}
