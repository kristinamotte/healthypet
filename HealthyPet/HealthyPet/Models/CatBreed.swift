//
//  CatBreed.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import Foundation

struct CatBreed: Codable {
    let weight: Weight
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let lifeSpan: String
    let description: String
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case temperament
        case origin
        case description
        case lifeSpan = "life_span"
        case image
    }
}
