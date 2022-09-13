//
//  AddNewPetViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 13/09/2022.
//

import Foundation

protocol AddNewPetViewModelDelegate: AnyObject {
    func showAddAnimalError()
}

class AddNewPetViewModel {
    // MARK: - Delegate
    weak var delegate: AddNewPetViewModelDelegate?
    
    // MARK: - Networking
    private let firebaseHelper: AddNewAnimal
    
    init(firebaseHelper: AddNewAnimal = FirebaseHelper(), delegate: AddNewPetViewModelDelegate?) {
        self.firebaseHelper = firebaseHelper
        self.delegate = delegate
    }
    
    func addNew(_ animal: Animal) {
        firebaseHelper.addNew(animal: animal) { error in
            if error != nil {
                self.delegate?.showAddAnimalError()
            }
        }
    }
}
