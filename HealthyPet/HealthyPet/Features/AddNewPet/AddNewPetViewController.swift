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
    @IBOutlet weak var petNameContainerView: UIView!
    @IBOutlet weak var animalKindLabel: UILabel!
    @IBOutlet weak var animalKindContainerView: UIView!
    @IBOutlet weak var animalKindValueLabel: UILabel!
    @IBOutlet weak var chooseBreedContainerView: UIView!
    @IBOutlet weak var chooseBreedLabel: UILabel!
    @IBOutlet weak var chooseBreedValueLabel: UILabel!
    @IBOutlet weak var birthdayContainerView: UIView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var genderValueLabel: UILabel!
    @IBOutlet weak var ownerNameContainerView: UIView!
    @IBOutlet weak var ownerPhoneContainerView: UIView!
    @IBOutlet weak var addNewAnimalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    

    // MARK: - Private methods
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        
        let placeholders: [UILabel] = [animalKindLabel, chooseBreedLabel, genderLabel, animalKindValueLabel, genderValueLabel, addPhotoLabel, chooseBreedValueLabel]
        placeholders.forEach {
            $0.font = Theme.Fonts.openSansLight12
            $0.textColor = Theme.Colors.black
        }
        
        let containers: [UIView] = [animalKindContainerView, chooseBreedContainerView, genderContainerView]
        containers.forEach {
            $0.layer.cornerRadius = Theme.Constants.cornerRadius
            $0.layer.borderWidth = Theme.Constants.defaultBorderWidth
            $0.layer.borderColor = Theme.Colors.mainGrey.cgColor
        }
        let petNameTextField: HealthyTextField = HealthyTextField.instanceFromNib()
        petNameTextField.configure(with: .simple(title: "Pet name"))
        petNameContainerView.add(subview: petNameTextField)
        
        let birthdayTextField: HealthyTextField = HealthyTextField.instanceFromNib()
        birthdayTextField.configure(with: .date(title: "Birthday date", placeholder: "2021-01-15"))
        birthdayContainerView.add(subview: birthdayTextField)
        
        let ownerNameTextField: HealthyTextField = HealthyTextField.instanceFromNib()
        ownerNameTextField.configure(with: .simple(title: "Owner name"))
        ownerNameContainerView.add(subview: ownerNameTextField)
        
        let ownerNumberTextField: HealthyTextField = HealthyTextField.instanceFromNib()
        ownerNumberTextField.configure(with: .simple(title: "Owner phone number"))
        ownerPhoneContainerView.add(subview: ownerNumberTextField)
        
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
