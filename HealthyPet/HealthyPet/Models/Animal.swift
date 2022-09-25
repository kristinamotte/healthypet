//
//  Animal.swift
//  HealthyPet
//
//  Created by Kristina Motte on 11/09/2022.
//

import UIKit

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
    
    var genderIcon: UIImage {
        let gender = Gender(rawValue: gender) ?? .female
        
        switch gender {
        case .female:
            return #imageLiteral(resourceName: "ic_female")
        case .male:
            return #imageLiteral(resourceName: "ic_male")
        }
    }
    
    var genderColor: UIColor {
        let gender = Gender(rawValue: gender) ?? .female
        
        switch gender {
        case .female:
            return Theme.Colors.rose
        case .male:
            return Theme.Colors.blue
        }
    }
    
    var age: String {
        let formatter = DateFormatter.addPetDateFormatter
        let date = formatter.date(from: birthday) ?? Date()
        
        let howMuchYears = Calendar.current.dateComponents([.year], from: date, to: Date()).year
        let howMuchMonth = Calendar.current.dateComponents([.month], from: date, to: Date()).month
        let howMuchDays = Calendar.current.dateComponents([.day], from: date, to: Date()).day
        
        if let howMuchYears = howMuchYears, howMuchYears > 0 {
            return howMuchYears == 1 ? "1 year" : "\(howMuchYears) years"
        }
        
        if let howMuchMonth = howMuchMonth, howMuchMonth > 0 {
            return howMuchMonth == 1 ? "1 month" : "\(howMuchMonth) months"
        }
        
        return howMuchDays == 1 ? "1 day" : "\(howMuchDays ?? 2) days"
    }
    
    enum Gender: String {
        case female = "Female"
        case male = "Male"
    }
}
