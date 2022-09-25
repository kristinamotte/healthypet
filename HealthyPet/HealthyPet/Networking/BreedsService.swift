//
//  BreedsService.swift
//  HealthyPet
//
//  Created by Kristina Motte on 15/09/2022.
//

import Foundation

protocol BreedsService {
    var dogBreeds: [DogBreed] { get }
    var catBreeds: [CatBreed] { get }
}

class BreedsServiceImpl: BreedsService {
    var dogBreeds: [DogBreed] {
        let breeds = Cache<[DogBreed]>(dataType: .dogBreeds).value ?? []
        return breeds
    }
    
    var catBreeds: [CatBreed] {
        let breeds = Cache<[CatBreed]>(dataType: .catBreeds).value ?? []
        return breeds
    }
}
