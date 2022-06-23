//
//  GetDogBreedsRequest.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import Foundation

final class GetDogBreedsRequest: Request {
    convenience init() {
        let url = URL(string: "https://api.thedogapi.com/v1/breeds")!
        
        self.init(url: url,
                  method: .GET,
                  headers: Headers.default.adding(.dogsApiKey))
    }
}
