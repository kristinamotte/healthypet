//
//  DogBreed.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import Foundation

struct DogBreedResponse: Codable {
    let breeds: [DogBreed]
    
    enum CodingKeys: String, CodingKey {
        case breeds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        breeds = try container.decode([DogBreed].self, forKey: .breeds)
    }
}

struct DogBreed: Codable {
    let weight: Weight
    let id: Int
    let name: String
    let breedFor: String?
    let lifeSpan: String
    let temperament: String?
    let origin: String?
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case breedFor = "bred_for"
        case lifeSpan = "life_span"
        case temperament
        case origin
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weight = try container.decode(Weight.self, forKey: .weight)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        breedFor = try? container.decode(String.self, forKey: .breedFor)
        lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        temperament = try? container.decode(String.self, forKey: .temperament)
        origin = try? container.decode(String.self, forKey: .origin)
        image = try container.decode(Image.self, forKey: .image)
    }
}

struct Weight: Codable {
    let imperial: String
    
    enum CodingKeys: String, CodingKey {
        case imperial
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imperial = try container.decode(String.self, forKey: .imperial)
    }
}

struct Image: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
    }
}
