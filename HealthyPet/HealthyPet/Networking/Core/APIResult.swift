//
//  APIResult.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

/// Represents universal API result
enum APIResult<T> {
    case success(T)
    case error(Error)
}
