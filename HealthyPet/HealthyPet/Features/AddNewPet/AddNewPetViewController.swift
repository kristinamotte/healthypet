//
//  AddNewPetViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 08/08/2022.
//

import UIKit
import FirebaseDatabase

class AddNewPetViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addNewPetScrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoContainerView: UIView!
    @IBOutlet weak var addPhotoLabel: UILabel!
    @IBOutlet weak var petNameContainerView: UIView!
    @IBOutlet weak var animalKindContainerView: UIView!
    @IBOutlet weak var chooseBreedContainerView: UIView!
    @IBOutlet weak var birthdayContainerView: UIView!
    @IBOutlet weak var genderContainerView: UIView!
    @IBOutlet weak var ownerNameContainerView: UIView!
    @IBOutlet weak var ownerPhoneContainerView: UIView!
    @IBOutlet weak var addNewAnimalButton: UIButton!

    // MARK: - Text fields
    let petNameTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    let birthdayTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    let ownerNameTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    let ownerNumberTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    
    // MARK: - Dropdowns
    let animalDropdown: HealthyDropdown = HealthyDropdown.instanceFromNib()
    let chooseBreedDropdown: HealthyDropdown = HealthyDropdown.instanceFromNib()
    let genderDropdown: HealthyDropdown = HealthyDropdown.instanceFromNib()
    
    // MARK: - View Model
    var viewModel: AddNewPetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        subscribeToNotifications(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotifications(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: - Private methods
    private func configureUI() {
        titleLabel.font = Theme.Fonts.openSansLight24
        titleLabel.textColor = Theme.Colors.black
        
        addPhotoLabel.font = Theme.Fonts.openSansLight12
        addPhotoLabel.textColor = Theme.Colors.black
        
        configureTextFields()
        configureDropdowns()
        
        photoContainerView.backgroundColor = Theme.Colors.lightBlue
        photoContainerView.layer.cornerRadius = Theme.Constants.cornerRadius
        addNewAnimalButton.layer.cornerRadius = addNewAnimalButton.frame.height / 2
        addNewAnimalButton.backgroundColor = Theme.Colors.rose
        addNewAnimalButton.titleLabel?.font = Theme.Fonts.openSansBold14
        addNewAnimalButton.titleLabel?.textColor = Theme.Colors.white
    }
    
    private func configureTextFields() {
        petNameTextField.configure(with: .simple(title: "Pet name"))
        petNameContainerView.add(subview: petNameTextField)
        
        birthdayTextField.configure(with: .date(title: "Birthday date", placeholder: "2021-01-15"))
        birthdayContainerView.add(subview: birthdayTextField)
        
        ownerNameTextField.configure(with: .simple(title: "Owner name"))
        ownerNameContainerView.add(subview: ownerNameTextField)
        
        ownerNumberTextField.configure(with: .phoneNumber(title: "Owner phone number"))
        ownerPhoneContainerView.add(subview: ownerNumberTextField)
        
    }
    
    private func configureDropdowns() {
        animalDropdown.configure(with: "What kind of animal it is?", preselected: "Dog")
        animalKindContainerView.add(subview: animalDropdown)
        let animalTap = UITapGestureRecognizer(target: self, action: #selector((didTapAnimalKindDropdown)))
        animalKindContainerView.addGestureRecognizer(animalTap)
        
        chooseBreedDropdown.configure(with: "Choose breed", preselected: "Mixed")
        chooseBreedContainerView.add(subview: chooseBreedDropdown)
        let breedTap = UITapGestureRecognizer(target: self, action: #selector((didTapBreedDropdown)))
        chooseBreedContainerView.addGestureRecognizer(breedTap)
        
        genderDropdown.configure(with: "Gender", preselected: "Female")
        genderContainerView.add(subview: genderDropdown)
        let genderTap = UITapGestureRecognizer(target: self, action: #selector((didTapGenderDropdown)))
        genderContainerView.addGestureRecognizer(genderTap)
    }
    
    private func subscribeToNotifications(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    @objc private func keyboardWillShowOrHide(_ notification: NSNotification) {
        if let scrollView = addNewPetScrollView,
           let userInfo = notification.userInfo,
           let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
           let durationValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey],
           let duration = (durationValue as AnyObject).doubleValue,
           let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)

            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            scrollView.contentInset.bottom = keyboardOverlap
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap

            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options: options) { [weak self] in
                self?.contentView.layoutIfNeeded()
            }
        }
    }
    
    @objc private func didTapAnimalKindDropdown() {
        
    }
    
    @objc private func didTapBreedDropdown() {
        
    }
    
    @objc private func didTapGenderDropdown() {
        
    }
    
    // MARK: - Actions
    @IBAction func didTapAddAnimal(_ sender: UIButton) {
        let dateFormatter = DateFormatter.addPetDateFormatter
        if !petNameTextField.isEmpty && !birthdayTextField.isEmpty && dateFormatter.date(from: birthdayTextField.text) != nil && !ownerNameTextField.isEmpty && !ownerNumberTextField.isEmpty {
            let animal = Animal(id: UUID().uuidString, imageUrl: nil, petName: petNameTextField.text, animalType: animalDropdown.text, breed: chooseBreedDropdown.text, birthday: birthdayTextField.text, gender: genderDropdown.text, ownerName: ownerNameTextField.text, ownerNumber: ownerNumberTextField.text)
            viewModel?.addNew(animal)
        } else {
            if petNameTextField.isEmpty {
                petNameTextField.set(error: "Please add your pet name")
            } else {
                petNameTextField.removeError()
            }
            
            if birthdayTextField.isEmpty {
                birthdayTextField.set(error: "Please add your pet birthday")
            } else if dateFormatter.date(from: birthdayTextField.text) == nil {
                birthdayTextField.set(error: "Please fullfill birthday correctly: YYYY-MM-DD")
            } else {
                birthdayTextField.removeError()
            }
            
            if ownerNameTextField.isEmpty {
                ownerNameTextField.set(error: "Please add owner name")
            } else {
                ownerNameTextField.removeError()
            }
            
            if ownerNumberTextField.isEmpty {
                ownerNumberTextField.set(error: "Please add owner number")
            } else {
                ownerNumberTextField.removeError()
            }
        }
    }
}

extension AddNewPetViewController: AddNewPetViewModelDelegate {
    func showAddAnimalError() {
        
    }
}

extension AddNewPetViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AddNewPet
    }
}
