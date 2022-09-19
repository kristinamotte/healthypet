//
//  BreedDetailsItem.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/09/2022.
//

import Foundation

enum BreedDetailsItem {
    case generalInfo(url: URL?, String, String?)
    case lifeSpan(String)
    case bredFor(String)
    case description(String)
    case temperament(String)
    case weight(String)
}
