//
//  API+Breeds.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import Foundation

extension API {
    func getDogBreeds(completion: @escaping APICompletion<[DogBreed]>) {
        let request = GetDogBreedsRequest()
            .withDefaultValidations()

        execute(
            request,
            parse: {
                let breeds = try? JSONDecoder().decode([DogBreed].self, from: $0)
                return breeds ?? []
        },
            cache: { try? DataCache.cache($0, dataType: .dogBreeds) },
            completion: completion
        )
    }
    
    func getCatBreeds(completion: @escaping APICompletion<[CatBreed]>) {
        let request = GetCatBreedsRequest()
            .withDefaultValidations()
        
        execute(
            request,
            parse: {
                let breeds = try? JSONDecoder().decode([CatBreed].self, from: $0)
                return breeds ?? []
        },
            cache: { try? DataCache.cache($0, dataType: .catBreeds) },
            completion: completion
        )
    }
}
