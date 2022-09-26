//
//  HomeViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func show(error: Error)
}

class HomeViewModel {
    // MARK: - Navigation
    var onAnimalDetails: ((Animal, URL?) -> Void)?
    
    // MARK: - Delegate
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Dependencies
    private let dataUpdater: HomeDataUpdater
    private let firebaseHelper: AllAnimals
    
    init(dataUpdater: HomeDataUpdater = HomeDataUpdaterImpl(), delegate: HomeViewModelDelegate?, firebaseHelper: AllAnimals = FirebaseHelper()) {
        self.dataUpdater = dataUpdater
        self.delegate = delegate
        self.firebaseHelper = firebaseHelper
    }
    
    var animals: [Animal] {
        Cache<[Animal]>(dataType: .pets).value ?? []
    }
    
    var dogs: [Animal] {
        animals.filter { $0.animalType == AnimalType.dog.rawValue }
    }
    
    var cats: [Animal] {
        animals.filter { $0.animalType == AnimalType.cat.rawValue }
    }
    
    func updateAllData(completion: @escaping (_ updated: Bool) -> Void) {
        dataUpdater.updateAllData { error in
            if let error = error {
                self.delegate?.show(error: error)
            }
            
            completion(true)
        }
    }
    
    func getImageUrl(id: String, path: String, completion: @escaping (URL?) -> Void) {
        let cachedImages = Cache<FirebaseImage>(dataType: .firebaseImage).arrayValue ?? []
        
        if let url = cachedImages.first(where: { $0.id == id })?.url {
            completion(url)
        } else {
            firebaseHelper.getImageUrl(id: id, path: path) { url in
                completion(url)
            }
        }
    }
    
    func getUrl(for animal: Animal) -> URL? {
        let cachedImages = Cache<FirebaseImage>(dataType: .firebaseImage).arrayValue ?? []
        
        return cachedImages.first(where: { $0.id == animal.id })?.url
    }
}
