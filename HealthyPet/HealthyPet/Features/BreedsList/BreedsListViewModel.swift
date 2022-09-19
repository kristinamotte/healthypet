//
//  BreedsListViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import Foundation

class BreedsListViewModel {
    // MARK: - Dependencies
    private let breedService: BreedsService
    
    init(breedService: BreedsService = BreedsServiceImpl()) {
        self.breedService = breedService
    }
    
    func getBreeds(for option: FilterType) -> [GeneralBreed] {
        let dogsBreeds: [GeneralBreed] = breedService.dogBreeds.map { GeneralBreed(name: $0.name, description: $0.breedFor, origin: $0.origin) }
        let catsBreeds: [GeneralBreed] = breedService.catBreeds.map { GeneralBreed(name: $0.name, description: $0.description, origin: $0.origin) }
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
