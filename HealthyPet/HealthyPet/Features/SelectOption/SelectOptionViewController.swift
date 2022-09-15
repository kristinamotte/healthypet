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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: SelectOptionViewModel?
    
    weak var delegate: SelectOptionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
    }
    
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

    @IBAction func didTapDoneButton(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.didChoose(option: self.viewModel?.selectedOption ?? "")
        }
    }
}

extension SelectOptionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let breeds = viewModel?.breeds ?? []
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let option = viewModel.breeds[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectBreedTableViewCell.identifier) as? SelectBreedTableViewCell {
            cell.configure(with: option)
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        let option = viewModel.breeds[indexPath.row]
        viewModel.selectedOption = option
    }
}

extension SelectOptionViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let viewModel = viewModel else { return false }
        
        return true
    }
}

extension SelectOptionViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AddNewPet
    }
}
