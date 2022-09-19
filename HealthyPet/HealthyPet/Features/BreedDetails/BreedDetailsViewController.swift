//
//  BreedDetailsViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import UIKit

class BreedDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - View Model
    var viewModel: BreedDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
    }
    
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        BreedInfoTableViewCell.register(in: tableView)
    }
    
    @objc private func didTapBackButton() {
        viewModel?.onPreviosScreen?()
    }
}

extension BreedDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.dataSource ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = (viewModel?.dataSource ?? [])[indexPath.row]
        
        switch item {
        case .generalInfo(let url, let name, let location):
            if let cell = tableView.dequeueReusableCell(withIdentifier: BreedInfoTableViewCell.identifier) as? BreedInfoTableViewCell {
                cell.selectionStyle = .none
                cell.configure(with: name, location: location, url: url)
                
                return cell
            }
        case .weight(let weight):
            return UITableViewCell()
        case .temperament(let temperament):
            return UITableViewCell()
        case .description(let description):
            return UITableViewCell()
        case .lifeSpan(let lifeSpan):
            return UITableViewCell()
        case .bredFor(let bredFor):
            return UITableViewCell()
        }
        
        
        return UITableViewCell()
    }
}

extension BreedDetailsViewController: StoryboardController {
    static var storyboard: Storyboard {
        .BreedsList
    }
}
