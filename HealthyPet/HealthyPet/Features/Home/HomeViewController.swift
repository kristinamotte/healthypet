//
//  HomeViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 16.06.2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var petsTableView: UITableView!
    @IBOutlet weak var emptyStateContainerView: UIView!
    lazy var searchView: SearchView = SearchView.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterView.add(subview: searchView)
        
        API.shared.getDogBreeds { result in
            
        }
        
        API.shared.getCatBreeds { result in
            
        }
    }
}

extension HomeViewController: StoryboardController {
    static var storyboard: Storyboard {
        .Main
    }
}
