//
//  BreedsListViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit

class BreedsListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - SearchView
    lazy var searchView: SearchView = SearchView.loadFromNib(delegate: self)
    
    var selectedFilterItem: FilterType = .all {
        didSet {
            configureFilteredData()
        }
    }
    
    var viewModel: BreedsListViewModel?
    
    private var breeds: [GeneralBreed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.configure(with: "Breeds library")
        filterContainerView.add(subview: searchView)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureFilteredData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        BreedTableViewCell.register(in: tableView)
    }
    
    private func configureFilteredData() {
        switch selectedFilterItem {
        case .all:
            breeds = viewModel?.getBreeds(for: selectedFilterItem) ?? []
        case .dogs:
            breeds = viewModel?.getBreeds(for: selectedFilterItem) ?? []
        case .cats:
            breeds = viewModel?.getBreeds(for: selectedFilterItem) ?? []
        }
        
        tableView.reloadData()
        
//        if !searchView.isSearchBarEmpty {
//            filterContentForSearchText(searchView.searchText)
//        } else {
//            setEmptyState()
//            petsTableView.reloadData()
//        }
    }
}

extension BreedsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if !searchView.isSearchBarEmpty {
//            return filteredAnimals.count
//        }
//
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchView.isSearchBarEmpty ? breeds[indexPath.row] : breeds[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: BreedTableViewCell.identifier) as? BreedTableViewCell {
            cell.selectionStyle = .none
            cell.configure(with: item)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - SearchViewDelegate
extension BreedsListViewController: SearchViewDelegate {
    func didSelect(option: FilterType) {
        selectedFilterItem = option
    }
    
    func didSearch(by text: String) {
        
    }
}

// MARK: - StoryboardController
extension BreedsListViewController: StoryboardController {
    static var storyboard: Storyboard {
        .BreedsList
    }
}
