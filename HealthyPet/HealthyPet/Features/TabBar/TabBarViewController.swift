//
//  TabBarViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    enum TabItem: Int {
        case home
        case addNew
        case breeds
    }
    
    var lastSelectIndex: Int = 0
    var indicatorImage: UIImageView = UIImageView()
    var coordinators: [Coordinator] = []
    
    override open var selectedIndex: Int {
        didSet {
            if let items = tabBar.items {
                guard selectedIndex < items.count else { return }
                
                tabBar(tabBar, didSelect: items[selectedIndex])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTabBarItems()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        tabBar.tintColor = Theme.Colors.blue
        tabBar.unselectedItemTintColor = Theme.Colors.mainGrey
        tabBar.backgroundColor = Theme.Colors.white
        tabBar.shadowImage = UIImage()
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = Theme.Constants.shadowRadius
        tabBar.layer.shadowColor = Theme.Colors.lightGrey.cgColor
        tabBar.layer.shadowOpacity = Theme.Constants.shadowOpacity
        
        if #available(iOS 15.0, *) {
            tabBar.backgroundImage = UIImage.init(color: Theme.Colors.white, size: CGSize(width: view.frame.width, height: tabBar.frame.height))
        } else {
            tabBar.backgroundImage = UIImage()
        }
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_line"))
        indicatorImage = imageView
        indicatorImage.center.y = Theme.Constants.indicatorImagePos
        tabBar.addSubview(indicatorImage)
    }

    private func configureTabBarItems() {
        let home = HomeCoordinator(presenter: UINavigationController())
        home.controller.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_home_unselected"), selectedImage: #imageLiteral(resourceName: "ic_home_selected"))
        home.start()
        home.delegate = self

        let addNew = HomeCoordinator(presenter: UINavigationController())
        addNew.controller.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_addNew_unselected"), selectedImage: #imageLiteral(resourceName: "ic_addNew_selected"))
        addNew.start()

        let breeds = HomeCoordinator(presenter: UINavigationController())
        breeds.controller.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic_breeds_unselected"), selectedImage: #imageLiteral(resourceName: "ic_breeds_selected"))
        breeds.start()

        coordinators = [home, addNew, breeds]
        viewControllers = [home.presenter, addNew.presenter, breeds.presenter]

        delegate = self
        
        selectedIndex = 0
        
        indicatorImage.center.x = tabBar.frame.width / CGFloat(coordinators.count) / 2
    }
}

// MARK: - CoordinatorDelegate
extension TabBarViewController: CoordinatorDelegate {
    func switchTab(with item: TabBarItem) {
        switch item {
        case .home:
            selectedIndex = TabItem.home.rawValue
        case .addNew:
            selectedIndex = TabItem.addNew.rawValue
        case .breeds:
            selectedIndex = TabItem.breeds.rawValue
        }
    }

    var tabBarNavigation: UINavigationController? {
        navigationController
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        true
    }
    
    override open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = self.tabBar.items, items.contains(item) {
            let array = items as NSArray
            let index = array.index(of: item)
            
            if index == lastSelectIndex {
                return
            } else {
                lastSelectIndex = index
            }
            
            UIView.animate(withDuration: Theme.Constants.defaultAnimationDuration) {
                let number = -(items.firstIndex(of: item)?.distance(to: 0) ?? 0) + 1
                let itemsCount = CGFloat(items.count)
                
                switch number {
                case 1:
                    self.indicatorImage.center.x =  tabBar.frame.width / itemsCount / 2
                case 2:
                    self.indicatorImage.center.x =  tabBar.frame.width / itemsCount / 2 + tabBar.frame.width / itemsCount
                case 3 where Int(number) != Int(itemsCount):
                    self.indicatorImage.center.x =  tabBar.frame.width / itemsCount / 2 + tabBar.frame.width / 2
                default:
                    self.indicatorImage.center.x = tabBar.frame.width - tabBar.frame.width / itemsCount / 2
                }
            }
        }
    }
}
