//
//  EditPetViewController.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit
import ToastViewSwift

protocol EditPetViewControllerDelegate: AnyObject {
    func didUpdate(animal: Animal, url: URL?)
}

class EditPetViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addNewPetScrollView: UIScrollView!
    @IBOutlet weak var backImageView: UIImageView!
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
    @IBOutlet weak var removeAnimalButton: UIButton!
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
    
    // MARK: - Delegate
    weak var delegate: EditPetViewControllerDelegate?
    
    // MARK: - View Model
    var viewModel: EditPetViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        imagePicker.delegate = self
        subscribeToNotifications(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotifications(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
        self.hideKeyboardWhenTappedAround()
        
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
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
        addNewAnimalButton.setTitleColor(Theme.Colors.white, for: .normal)
        removeAnimalButton.titleLabel?.font = Theme.Fonts.openSansBold14
        removeAnimalButton.setTitleColor(Theme.Colors.rose, for: .normal)
        
        if let viewModel = viewModel, let url = viewModel.url {
            photoImageView.isHidden = false
            photoImageView.loadImage(at: url, placeholder: nil) {
                self.addPhotoStackView.isHidden = true
            }
        } else {
            photoImageView.isHidden = true
        }
        photoContainerView.isUserInteractionEnabled = true
        photoContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectPetImage)))
    }
    
    private func configureTextFields() {
        guard let viewModel = viewModel else { return }
        
        petNameTextField.configure(with: .simple(title: "Pet name"))
        petNameTextField.update(with: viewModel.animal.petName)
        petNameContainerView.add(subview: petNameTextField)
        
        birthdayTextField.configure(with: .date(title: "Birthday date", placeholder: "2021-01-15"))
        birthdayTextField.update(with: viewModel.animal.birthday)
        birthdayContainerView.add(subview: birthdayTextField)
        
        ownerNameTextField.configure(with: .simple(title: "Owner name"))
        ownerNameTextField.update(with: viewModel.animal.ownerName)
        ownerNameContainerView.add(subview: ownerNameTextField)
        
        ownerNumberTextField.configure(with: .phoneNumber(title: "Owner phone number"))
        ownerNumberTextField.update(with: viewModel.animal.ownerNumber)
        ownerPhoneContainerView.add(subview: ownerNumberTextField)
        
    }
    
    private func configureDropdowns() {
        guard let viewModel = viewModel else { return }
        
        animalDropdown.configure(with: "What kind of animal it is?", preselected: viewModel.animal.animalType)
        animalKindContainerView.add(subview: animalDropdown)
        let animalTap = UITapGestureRecognizer(target: self, action: #selector((didTapAnimalKindDropdown)))
        animalKindContainerView.addGestureRecognizer(animalTap)
        
        chooseBreedDropdown.configure(with: "Choose breed", preselected: viewModel.animal.breed)
        chooseBreedContainerView.add(subview: chooseBreedDropdown)
        let breedTap = UITapGestureRecognizer(target: self, action: #selector((didTapBreedDropdown)))
        chooseBreedContainerView.addGestureRecognizer(breedTap)
        
        genderDropdown.configure(with: "Gender", preselected:viewModel.animal.gender)
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
    
    @objc private func didTapBackButton() {
        guard let viewModel = viewModel else { return }
        
        viewModel.onPreviousScreen?()
        
        if viewModel.isEdited {
            let animal = Animal(id: viewModel.animal.id, imageUrl: nil, petName: petNameTextField.text, animalType: animalDropdown.text, breed: chooseBreedDropdown.text, birthday: birthdayTextField.text, gender: genderDropdown.text, ownerName: ownerNameTextField.text, ownerNumber: ownerNumberTextField.text)
            delegate?.didUpdate(animal: animal, url: viewModel.url)
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
            let animal = Animal(id: viewModel?.animal.id ?? "", imageUrl: nil, petName: petNameTextField.text, animalType: animalDropdown.text, breed: chooseBreedDropdown.text, birthday: birthdayTextField.text, gender: genderDropdown.text, ownerName: ownerNameTextField.text, ownerNumber: ownerNumberTextField.text)
            addNewAnimalButton.showSpinner(tintColor: Theme.Colors.white)
            viewModel?.update(animal, image: photoImageView.image)
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
    
    @IBAction func didTapRemoveButton(_ sender: UIButton) {
        removeAnimalButton.showSpinner(tintColor: Theme.Colors.blue)
        
        viewModel?.removeAnimal { error in
            self.removeAnimalButton.hideSpinner()
            
            if error != nil {
                let toast = Toast.default(image: #imageLiteral(resourceName: "ic_error"), title: "Something went wrong", subtitle: "Please try again")
                toast.show()
            } else {
                let toast = Toast.default(image: #imageLiteral(resourceName: "ic_success"), title: "Animal successfully removed")
                toast.show()
                
                self.viewModel?.onParentScreen?()
            }
        }
    }
}

extension EditPetViewController: AddNewPetViewModelDelegate {
    func showAddAnimalError() {
        addNewAnimalButton.hideSpinner()
        let toast = Toast.default(image: #imageLiteral(resourceName: "ic_error"), title: "Something went wrong", subtitle: "Please try again")
        toast.show()
    }
    
    func showAnimalAdded() {
        addNewAnimalButton.hideSpinner()
        let toast = Toast.default(image: #imageLiteral(resourceName: "ic_success"), title: "Animal info successfully updated")
        toast.show()
    }
}

extension EditPetViewController: SelectOptionViewControllerDelegate {
    func didChoose(option: String) {
        chooseBreedDropdown.updatePreselected(option: option)
    }
}

extension EditPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension EditPetViewController: StoryboardController {
    static var storyboard: Storyboard {
        .AddNewPet
    }
}
