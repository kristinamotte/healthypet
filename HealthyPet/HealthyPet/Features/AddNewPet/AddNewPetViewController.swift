//
//  AddNewPetViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 08/08/2022.
//

import UIKit
import FirebaseDatabase
import ToastViewSwift

class AddNewPetViewController: UIViewController {
    // MARK: - Outlets
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
    @IBOutlet weak var addPhotoStackView: UIStackView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: - Text fields
    let petNameTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    let birthdayTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    let ownerNameTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    let ownerNumberTextField: HealthyTextField = HealthyTextField.instanceFromNib()
    
    // MARK: - Dropdowns
    let animalDropdown: HealthyDropdown = HealthyDropdown.instanceFromNib()
    let chooseBreedDropdown: HealthyDropdown = HealthyDropdown.instanceFromNib()
    let genderDropdown: HealthyDropdown = HealthyDropdown.instanceFromNib()
    
    // MARK: - Image Picker Controller
    let imagePicker = UIImagePickerController()
    
    // MARK: - View Model
    var viewModel: AddNewPetViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        imagePicker.delegate = self
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
        photoImageView.isHidden = true
        photoContainerView.isUserInteractionEnabled = true
        photoContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectPetImage)))
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
        let options = [AnimalType.dog.rawValue, AnimalType.cat.rawValue]
        showAlert(for: options) { option in
            self.animalDropdown.updatePreselected(option: option)
            self.chooseBreedDropdown.updatePreselected(option: "Mixed")
        }
    }
    
    @objc private func didTapBreedDropdown() {
        guard let viewModel = viewModel else { return }
        
        let selectedAnimalType = AnimalType(rawValue: animalDropdown.text) ?? .dog
        let breeds = viewModel.getBreeds(for: selectedAnimalType)
        
        viewModel.onSelectBreeds?(breeds, chooseBreedDropdown.text)
    }
    
    @objc private func didTapGenderDropdown() {
        let options = ["Female", "Male"]
        showAlert(for: options) { option in
            self.genderDropdown.updatePreselected(option: option)
        }
    }
    
    private func showAlert(for options: [String], _ completion: @escaping ((String) -> Void)) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for option in options {
            let action = UIAlertAction(title: option, style: .default) { _ in
                completion(option)
            }
            
            actionSheet.addAction(action)
        }

        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(action)

        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func didSelectPetImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction private func didTapAddAnimal(_ sender: UIButton) {
        let dateFormatter = DateFormatter.addPetDateFormatter
        if !petNameTextField.isEmpty && !birthdayTextField.isEmpty && dateFormatter.date(from: birthdayTextField.text) != nil && !ownerNameTextField.isEmpty && !ownerNumberTextField.isEmpty {
            let animal = Animal(id: UUID().uuidString, imageUrl: nil, petName: petNameTextField.text, animalType: animalDropdown.text, breed: chooseBreedDropdown.text, birthday: birthdayTextField.text, gender: genderDropdown.text, ownerName: ownerNameTextField.text, ownerNumber: ownerNumberTextField.text)
            addNewAnimalButton.showSpinner(tintColor: Theme.Colors.white)
            viewModel?.addNew(animal, image: photoImageView.image)
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
        addNewAnimalButton.hideSpinner()
        let toast = Toast.default(image: #imageLiteral(resourceName: "ic_error"), title: "Something went wrong", subtitle: "Please try again")
        toast.show()
    }
    
    func showAnimalAdded() {
        // Set default values
        let textFields: [HealthyTextField] = [petNameTextField, ownerNameTextField, ownerNumberTextField]
        
        textFields.forEach { $0.textField.text = "" }
        birthdayTextField.configure(with: .date(title: "Birthday date", placeholder: "2021-01-15"))
        animalDropdown.configure(with: "What kind of animal it is?", preselected: "Dog")
        chooseBreedDropdown.configure(with: "Choose breed", preselected: "Mixed")
        genderDropdown.configure(with: "Gender", preselected: "Female")
        photoImageView.image = nil
        photoImageView.isHidden = true
        addPhotoStackView.isHidden = false
        
        addNewAnimalButton.hideSpinner()
        let toast = Toast.default(image: #imageLiteral(resourceName: "ic_success"), title: "Animal successfully added")
        toast.show()
    }
}

extension AddNewPetViewController: SelectOptionViewControllerDelegate {
    func didChoose(option: String) {
        chooseBreedDropdown.updatePreselected(option: option)
    }
}

extension AddNewPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.isHidden = false
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.image = pickedImage
            addPhotoStackView.isHidden = true
        }

        dismiss(animated: true, completion: nil)
    }
}

extension AddNewPetViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AddNewPet
    }
}
