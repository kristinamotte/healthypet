//
//  AnimalDetailsViewModel.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import Foundation

class AnimalDetailsViewModel {
    var onPreviosScreen: (() -> Void)?
    var onGeneratedPdf: ((URL) -> Void)?
    
    let animal: Animal
    let animalImageUrl: URL?
    
    init(animal: Animal, animalImageUrl: URL?) {
        self.animal = animal
        self.animalImageUrl = animalImageUrl
    }
}
