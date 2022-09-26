//
//  EditPetViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import UIKit

class EditPetViewModel {
    // MARK: - Navigation
    var onSelectBreeds: (([String], String) -> Void)?
    var onPreviousScreen: (() -> Void)?
    var onParentScreen: (() -> Void)?
    
    // MARK: - Dependencies
    var animal: Animal
    var url: URL?
    var isEdited: Bool = false
    
    // MARK: - Delegate
    weak var delegate: AddNewPetViewModelDelegate?
    
    // MARK: - Networking
    private let firebaseHelper: EditAnimal
    private let breedsService: BreedsService
    
    init(animal: Animal, url: URL?, firebaseHelper: EditAnimal = FirebaseHelper(), delegate: AddNewPetViewModelDelegate?, breedsService: BreedsService = BreedsServiceImpl()) {
        self.animal = animal
        self.url = url
        self.firebaseHelper = firebaseHelper
        self.delegate = delegate
        self.breedsService = breedsService
    }
    
    func getBreeds(for category: AnimalType) -> [String] {
        switch category {
        case .dog:
            var breeds = breedsService.dogBreeds.map { $0.name }
            breeds.append("Mixed")
            
            return breeds
        case .cat:
            var breeds = breedsService.catBreeds.map { $0.name }
            breeds.append("Mixed")
            
            return breeds
        }
    }
    
    func update(_ animal: Animal, image: UIImage?) {
        if let image = image {
            firebaseHelper.uploadImage(image: image, id: animal.id) { error, path in
                guard let path = path, error == nil else  {
                    self.delegate?.showAddAnimalError()
                    return
                }
                
                var newAnimal = animal
                newAnimal.imageUrl = path
                
                self.update(animal: newAnimal)
            }
        } else {
            update(animal: animal)
        }
    }
    
    func removeAnimal(_ completion: @escaping (Error?) -> Void) {
        firebaseHelper.delete(animal: animal) { error in
           completion(error)
        }
    }
    
    private func update(animal: Animal) {
        firebaseHelper.edit(animal: animal) { error in
            if error != nil {
                self.delegate?.showAddAnimalError()
            } else {
                self.isEdited = true
                self.delegate?.showAnimalAdded()
            }
        }
    }
}
