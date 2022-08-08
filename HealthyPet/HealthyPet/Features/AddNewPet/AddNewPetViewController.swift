//
//  AddNewPetViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 08/08/2022.
//

import UIKit

class AddNewPetViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var addPhotoLabel: UILabel!
    @IBOutlet weak var petNameTitle: UILabel!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var animalKindLabel: UILabel!
    @IBOutlet weak var animalKindContainerView: UIView!
    @IBOutlet weak var animalKindValueLabel: UILabel!
    @IBOutlet weak var chooseBreedContainerView: UIView!
    @IBOutlet weak var chooseBreedLabel: UILabel!
    @IBOutlet weak var chooseBreedValueLabel: UILabel!
    @IBOutlet weak var birthdayDateLabel: UILabel!
    @IBOutlet weak var birthdayDateTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var genderValueLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerNumberLabel: UILabel!
    @IBOutlet weak var ownerNumberTextField: UITextField!
    @IBOutlet weak var addNewAnimalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    

    // MARK: - Private methods
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        
        let placeholders: [UILabel] = [petNameTitle, animalKindLabel, chooseBreedLabel, birthdayDateLabel, genderLabel, ownerNameLabel, animalKindValueLabel, genderValueLabel, addPhotoLabel, ownerNumberLabel, chooseBreedValueLabel]
        placeholders.forEach {
            $0.font = Theme.Fonts.openSansLight12
            $0.textColor = Theme.Colors.black
        }
        
        let textFields: [UITextField] = [petNameTextField, birthdayDateTextField, ownerNameTextField, ownerNumberTextField]
        textFields.forEach {
            $0.layer.cornerRadius = Theme.Constants.cornerRadius
            $0.layer.borderWidth = Theme.Constants.defaultBorderWidth
            $0.layer.borderColor = Theme.Colors.mainGrey.cgColor
            $0.tintColor = Theme.Colors.rose
            $0.font = Theme.Fonts.openSansLight12
            $0.textColor = Theme.Colors.black
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: $0.frame.height))
            $0.leftView = paddingView
            $0.leftViewMode = .always
        }
        
        let containers: [UIView] = [animalKindContainerView, chooseBreedContainerView, genderContainerView]
        containers.forEach {
            $0.layer.cornerRadius = Theme.Constants.cornerRadius
            $0.layer.borderWidth = Theme.Constants.defaultBorderWidth
            $0.layer.borderColor = Theme.Colors.mainGrey.cgColor
        }
        
        photoContainerView.backgroundColor = Theme.Colors.lightBlue
        photoContainerView.layer.cornerRadius = Theme.Constants.cornerRadius
        addNewAnimalButton.layer.cornerRadius = addNewAnimalButton.frame.height / 2
        addNewAnimalButton.backgroundColor = Theme.Colors.rose
        addNewAnimalButton.titleLabel?.font = Theme.Fonts.openSansBold14
        addNewAnimalButton.titleLabel?.textColor = Theme.Colors.white
    }
}

extension AddNewPetViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AddNewPet
    }
}
