//
//  SelectOptionViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 11/09/2022.
//

import UIKit

protocol SelectOptionViewControllerDelegate: AnyObject {
    func didChoose(option: String)
}

class SelectOptionViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - View Model
    var viewModel: SelectOptionViewModel?
    
    // MARK: - Delegate
    weak var delegate: SelectOptionViewControllerDelegate?
    
    // MARK: - Helpers
    private var filteredBreeds: [String] = []
    
    private var isSearchBarEmpty: Bool {
        searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        configureUI()
        configureTableView()
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        doneButton.titleLabel?.textColor = Theme.Colors.blue
        doneButton.titleLabel?.font = Theme.Fonts.openSansBold14
        searchBar.searchTextField.font = Theme.Fonts.openSansRegular14
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        SelectBreedTableViewCell.register(in: tableView)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        guard let viewModel = viewModel else { return }
        
        filteredBreeds = viewModel.breeds.filter { $0.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
    
    @IBAction private func didTapDoneButton(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.didChoose(option: self.viewModel?.selectedOption ?? "")
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SelectOptionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearchBarEmpty {
            return filteredBreeds.count
        }
        
        let breeds = viewModel?.breeds ?? []
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let option = isSearchBarEmpty ? viewModel.breeds[indexPath.row] : filteredBreeds[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectBreedTableViewCell.identifier) as? SelectBreedTableViewCell {
            cell.configure(with: option)
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        let option = isSearchBarEmpty ? viewModel.breeds[indexPath.row] : filteredBreeds[indexPath.row]
        viewModel.selectedOption = option
    }
}

// MARK: - UISearchBarDelegate
extension SelectOptionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text ?? "")
    }
}

// MARK: - StoryboardController
extension SelectOptionViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AddNewPet
    }
}
