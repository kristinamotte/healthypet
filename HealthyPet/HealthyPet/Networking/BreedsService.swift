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
        var breeds = Cache<[DogBreed]>(dataType: .dogBreeds).value ?? []
        return breeds
    }
    
    var catBreeds: [CatBreed] {
        var breeds = Cache<[CatBreed]>(dataType: .catBreeds).value ?? []
        return breeds
    }
}
