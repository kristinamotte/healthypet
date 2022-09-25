//
//  GetCatBreedsRequest.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import Foundation

final class GetCatBreedsRequest: Request {
    convenience init() {
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        
        self.init(url: url,
                  method: .GET,
                  headers: Headers.default.adding(.catsApiKey))
    }
}
