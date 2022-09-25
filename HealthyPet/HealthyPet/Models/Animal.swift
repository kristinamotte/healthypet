//
//  Animal.swift
//  HealthyPet
//
//  Created by Kristina Motte on 11/09/2022.
//

import Foundation

struct Animal: Codable {
    let id: String
    var imageUrl: String?
    let petName: String
    let animalType: String
    let breed: String
    let birthday: String
    let gender: String
    let ownerName: String
    let ownerNumber: String
}
