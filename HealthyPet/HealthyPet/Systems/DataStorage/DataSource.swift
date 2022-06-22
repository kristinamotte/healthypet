//
//  DataSource.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

enum DataSource {
    case dogBreeds
    case catBreeds
    case allPets
    
    /// Get a list of all data sources
    static let all: [DataSource] = [.dogBreeds, .catBreeds, .allPets]
    
    /// Get a list of those data sources that have their TTL timed out
    static var timedOut: [DataSource] {
        DataSource.all.filter { DataCache.age(for: $0.dataType) > $0.TTL }
    }
    
    /// Data TTL intervals
    var TTL: TimeInterval {
        switch self {
        case .dogBreeds, .catBreeds:
            return .day
        case .allPets:
            return .minute
        }
    }
    
    var dataType: DataCache.DataType {
        switch self {
        case .dogBreeds:
            return .dogBreeds
        case .catBreeds:
            return .dogBreeds
        case .allPets:
            return .pets
        }
    }
}
