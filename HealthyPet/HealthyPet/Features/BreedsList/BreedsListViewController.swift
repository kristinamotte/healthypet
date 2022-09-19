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
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - SearchView
    lazy var searchView: SearchView = SearchView.loadFromNib(delegate: self)
    
    var selectedFilterItem: FilterType = .all {
        didSet {
            configureFilteredData()
        }
    }
    
    // MARK: - View Model
    var viewModel: BreedsListViewModel?
    
    // MARK: - Data source
    private var breeds: [GeneralBreed] = []
    private var filteredBreeds: [GeneralBreed] = []
    
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
        
        if !searchView.isSearchBarEmpty {
            filterContentForSearchText(searchView.searchText)
        } else {
            setEmptyState()
            tableView.reloadData()
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredBreeds = breeds.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        setEmptyState()
        tableView.reloadData()
    }
    
    private func setEmptyState() {
        if (!breeds.isEmpty && !searchView.isSearchBarEmpty && filteredBreeds.isEmpty) || breeds.isEmpty {
            let emptyVc = HomeEmptyViewController.fromStoryboard
            emptyVc.type = .empty
            emptyStateContainerView.isHidden = false
            tableView.isHidden = true
            addChildViewController(emptyVc, containerView: emptyStateContainerView)
        } else {
            emptyStateContainerView.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension BreedsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchView.isSearchBarEmpty {
            return filteredBreeds.count
        }

        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchView.isSearchBarEmpty ? breeds[indexPath.row] : filteredBreeds[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: BreedTableViewCell.identifier) as? BreedTableViewCell {
            cell.selectionStyle = .none
            cell.configure(with: item)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchView.isSearchBarEmpty ? breeds[indexPath.row] : filteredBreeds[indexPath.row]
        
        viewModel?.onBreedDetails?(item)
    }
}

// MARK: - SearchViewDelegate
extension BreedsListViewController: SearchViewDelegate {
    func didSelect(option: FilterType) {
        selectedFilterItem = option
    }
    
    func didSearch(by text: String) {
        filterContentForSearchText(text)
    }
}

// MARK: - StoryboardController
extension BreedsListViewController: StoryboardController {
    static var storyboard: Storyboard {
        .BreedsList
    }
}
