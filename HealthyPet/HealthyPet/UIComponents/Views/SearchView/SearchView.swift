//
//  SearchView.swift
//  HealthyPet
//
//  Created by Kristina Motte on 06.07.2022.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didSelect(option: FilterType)
    func didSearch(by text: String)
}

class SearchView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var findPetContainerView: UIView!
    @IBOutlet weak var findPetStackView: UIStackView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var crossImageView: UIImageView!
    
    weak var delegate: SearchViewDelegate?
    private lazy var filterView: FilterView = FilterView.loadFromNib(delegate: self)
    
    var isSearchBarEmpty: Bool {
        searchBar.text?.isEmpty ?? true
    }
    
    var searchText: String {
        searchBar.text ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        searchBar.delegate = self
        searchImageView.isUserInteractionEnabled = true
        crossImageView.isUserInteractionEnabled = true
        searchImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSearch)))
        crossImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseSearch)))
    }
    
    // MARK: - Life cycle
    class func loadFromNib(delegate: SearchViewDelegate? = nil) -> SearchView {
        let view = Bundle.main.loadNibNamed("SearchView", owner: nil, options: nil)?.first as! SearchView
        view.delegate = delegate
        return view
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private methods
    private func configureUI() {
        searchBar.searchTextField.font = Theme.Fonts.openSansRegular14
        searchContainerView.isHidden = true
        findPetContainerView.isHidden = false
        filterContainerView.add(subview: filterView)
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
        searchBar.text = nil
        searchBar.resignFirstResponder()
        delegate?.didSearch(by: searchText)
        
        UIView.animate(withDuration: Theme.Constants.defaultAnimationDuration, delay: 0.0, options: .curveEaseInOut) {
            self.searchContainerView.isHidden = true
            self.findPetContainerView.isHidden = false
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        delegate?.didSearch(by: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didSearch(by: searchBar.text ?? "")
    }
}

// MARK: - FilterViewDelegate
extension SearchView: FilterViewDelegate {
    func didSelect(option: FilterType) {
        delegate?.didSelect(option: option)
    }
}
