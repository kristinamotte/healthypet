//
//  BreedDetailsViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import Foundation

class BreedDetailsViewModel {
    // MARK: - Navigation
    var onPreviosScreen: (() -> Void)?
    
    // MARK: - Dependencies
    let breed: GeneralBreed
    
    init(breed: GeneralBreed) {
        self.breed = breed
    }
    
    var dataSource: [BreedDetailsItem] {
        switch breed.animalType {
        case .cat:
            var catsDefaultData: [BreedDetailsItem] = [.generalInfo(url: breed.url, breed.name, breed.origin), .lifeSpan(breed.lifeSpan)]
            
            if let description = breed.description {
                catsDefaultData.append(.description(description))
            }
            
            if let temperament = breed.temperament {
                catsDefaultData.append(.temperament(temperament))
            }
            
            catsDefaultData.append(.weight(breed.weight))
            
            return catsDefaultData
        case .dog:
            var dogsDefaultData: [BreedDetailsItem] = [.generalInfo(url: breed.url, breed.name, breed.origin), .lifeSpan(breed.lifeSpan)]
            
            if let description = breed.description {
                dogsDefaultData.append(.bredFor(description))
            }
            
            if let temperament = breed.temperament {
                dogsDefaultData.append(.temperament(temperament))
            }
            
            dogsDefaultData.append(.weight(breed.weight))
            
            return dogsDefaultData
        }
    }
}
