//
//  URL+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

extension URL {
    func with(queryItems: [URLQueryItem]) -> URL {
        guard !queryItems.isEmpty else { return self }
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url!
    }
}
