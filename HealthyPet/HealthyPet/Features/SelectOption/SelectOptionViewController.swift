//
//  SelectOptionViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 11/09/2022.
//

import UIKit

class SelectOptionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        doneButton.titleLabel?.textColor = Theme.Colors.blue
        doneButton.titleLabel?.font = Theme.Fonts.openSansBold14
    }

    @IBAction func didTapDoneButton(_ sender: UIButton) {
        
    }
}
