//
//  DateFormatter+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 11/09/2022.
//

import Foundation

extension DateFormatter {
    /**
    Formatter to parse API dates in the format yyyy-MM-dd
    */
    static let addPetDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
