//
//  AddNewPetViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 13/09/2022.
//

import UIKit

protocol AddNewPetViewModelDelegate: AnyObject {
    func showAddAnimalError()
    func showAnimalAdded()
}

class AddNewPetViewModel {
    var onSelectBreeds: (([String], String) -> Void)?
    
    // MARK: - Delegate
    weak var delegate: AddNewPetViewModelDelegate?
    
    // MARK: - Networking
    private let firebaseHelper: AddNewAnimal
    private let breedsService: BreedsService
    
    init(firebaseHelper: AddNewAnimal = FirebaseHelper(), delegate: AddNewPetViewModelDelegate?, breedsService: BreedsService = BreedsServiceImpl()) {
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
            return []
        }
    }
    
    func addNew(_ animal: Animal, image: UIImage?) {
        if let image = image {
            firebaseHelper.uploadImage(image: image, id: animal.id) { error, path in
                guard let path = path, error == nil else  {
                    self.delegate?.showAddAnimalError()
                    return
                }
                
                var newAnimal = animal
                newAnimal.imageUrl = path
                
                self.addNew(animal: newAnimal)
            }
        } else {
            addNew(animal: animal)
        }
    }
    
    private func addNew(animal: Animal) {
        firebaseHelper.addNew(animal: animal) { error in
            if error != nil {
                self.delegate?.showAddAnimalError()
            } else {
                self.delegate?.showAnimalAdded()
            }
        }
    }
}
