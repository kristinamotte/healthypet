//
//  BreedsListViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import Foundation

class BreedsListViewModel {
    // MARK: - Navigation
    var onBreedDetails: ((GeneralBreed) -> Void)?
    
    // MARK: - Dependencies
    private let breedService: BreedsService
    
    init(breedService: BreedsService = BreedsServiceImpl()) {
        self.breedService = breedService
    }
    
    func getBreeds(for option: FilterType) -> [GeneralBreed] {
        let dogsBreeds: [GeneralBreed] = breedService.dogBreeds.map { GeneralBreed(animalType: .dog, name: $0.name, description: $0.breedFor, origin: $0.origin, lifeSpan: $0.lifeSpan, temperament: $0.temperament, weight: $0.weight.imperial, url: URL(string: $0.image.url)) }
        let catsBreeds: [GeneralBreed] = breedService.catBreeds.map { GeneralBreed(animalType: .cat, name: $0.name, description: $0.description, origin: $0.origin, lifeSpan: $0.lifeSpan, temperament: $0.temperament, weight: $0.weight.imperial, url: URL(string: $0.image?.url ?? "")) }
        let all = dogsBreeds + catsBreeds
        
        switch option {
        case .all:
            return all
        case .dogs:
            return dogsBreeds
        case .cats:
            return catsBreeds
        }
    }
}
