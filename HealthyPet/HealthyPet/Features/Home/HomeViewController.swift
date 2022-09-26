//
//  HomeViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 16.06.2022.
//

import UIKit
import ToastViewSwift

class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var petsTableView: UITableView!
    @IBOutlet weak var emptyStateContainerView: UIView!
    
    // MARK: - SearchView
    lazy var searchView: SearchView = SearchView.loadFromNib(delegate: self)
    
    // MARK: - View Model
    var viewModel: HomeViewModel?
    
    var selectedFilterItem: FilterType = .all {
        didSet {
            configureFilteredData()
        }
    }
    
    private var isFirstLoading = true
    private var animals: [Animal] = []
    private var filteredAnimals: [Animal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterView.add(subview: searchView)
        emptyStateContainerView.isHidden = true
        petsTableView.isHidden = false
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureEmptyState()
        
        viewModel?.updateAllData { updated in
            if updated {
                self.isFirstLoading = false
                self.configureEmptyState()
                self.configureFilteredData()
            }
        }
    }
    
    private func configureTableView() {
        petsTableView.delegate = self
        petsTableView.dataSource = self
        petsTableView.separatorStyle = .none
        AnimalTableViewCell.register(in: petsTableView)
    }
    
    private func configureEmptyState() {
        if isFirstLoading {
            let emptyVc = HomeEmptyViewController.fromStoryboard
            emptyStateContainerView.isHidden = false
            petsTableView.isHidden = true
            addChildViewController(emptyVc, containerView: emptyStateContainerView)
        } else {
            emptyStateContainerView.isHidden = true
            petsTableView.isHidden = false
        }
    }
    
    private func configureFilteredData() {
        switch selectedFilterItem {
        case .all:
            animals = viewModel?.animals ?? []
        case .dogs:
            animals = viewModel?.dogs ?? []
        case .cats:
            animals = viewModel?.cats ?? []
        }
        
        if !searchView.isSearchBarEmpty {
            filterContentForSearchText(searchView.searchText)
        } else {
            petsTableView.reloadData()
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredAnimals = animals.filter { $0.petName.lowercased().contains(searchText.lowercased()) }
        
        petsTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchView.isSearchBarEmpty {
            return filteredAnimals.count
        }
        
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchView.isSearchBarEmpty ? animals[indexPath.row] : filteredAnimals[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.identifier) as? AnimalTableViewCell {
            cell.selectionStyle = .none
            cell.configure(with: item)
            
            if let path = item.imageUrl {
                viewModel?.getImageUrl(id: item.id, path: path) { url in
                    if let url = url {
                        cell.loadImage(for: url)
                    } else {
                        cell.setPlaceholder()
                    }
                }
            } else {
                cell.setPlaceholder()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func show(error: Error) {
        let toast = Toast.default(image: #imageLiteral(resourceName: "ic_error"), title: "Something went wrong", subtitle: "Please try again")
        toast.show()
    }
}

extension HomeViewController: SearchViewDelegate {
    func didSearch(by text: String) {
        filterContentForSearchText(text)
    }
    
    func didSelect(option: FilterType) {
        selectedFilterItem = option
    }
}

extension HomeViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
