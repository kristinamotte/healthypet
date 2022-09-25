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
    lazy var searchView: SearchView = SearchView.instanceFromNib()
    
    // MARK: - View Model
    var viewModel: HomeViewModel?
    
    private var isFirstLoading = true
    
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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

extension HomeViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
