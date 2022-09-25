//
//  HomeDataUpdater.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import Foundation
import PromiseKit

protocol HomeDataUpdater {
    func updateAllData(_ completion: @escaping (Error?) -> Void)
}

final class HomeDataUpdaterImpl: HomeDataUpdater {
    private let service: API
    private let firebaseHelper: AllAnimals
    
    init(service: API = .shared, firebaseHelper: AllAnimals = FirebaseHelper()) {
        self.service = service
        self.firebaseHelper = firebaseHelper
    }
    
    func updateAllData(_ completion: @escaping (Error?) -> Void) {
        service.getDogBreeds().then {  _ -> Promise<[CatBreed]> in
            return self.service.getCatBreeds()
        }.then { _ -> Promise<[Animal]> in
            return self.firebaseHelper.getAllAnimals()
        }.done { _ in
            completion(nil)
        }.catch { error in
            completion(error)
        }
    }
}
