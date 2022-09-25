//
//  Headers.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import Foundation

/// HTTP request headers
typealias Headers = [String: String]

/// Custom header keys
struct APIHeaderKeys {
    static let contentType = "Content-Type"
    static let apiKey = "x-api-key"
}

/// Custom header values
struct APIHeaderValues {
    static let json = "application/json"
    static let apiKey = "d18e6949-d4d5-48dc-9155-6dd25618d150"
    static let catsApiKey = "live_b62ydSFx0OWhavIMbYxTGpVNrn76nEf8PkuliCwuVyVG8SAn002C5TpHW1rXCV5J"
}

// MARK: - Predefined headers
extension Dictionary where Key == String, Value == String {
    static var `default`: Headers {
        let headers = [APIHeaderKeys.contentType: APIHeaderValues.json]

        return headers
    }
    
    static var dogsApiKey: [String: String] {
        [APIHeaderKeys.apiKey: APIHeaderValues.apiKey]
    }
    
    static var catsApiKey: [String: String] {
        [APIHeaderKeys.apiKey: APIHeaderValues.catsApiKey]
    }
}

// MARK: - Composing headers
extension Dictionary where Key == String, Value == String {
    func adding(_ headers: Headers...) -> Headers {
        var copy = self
        for header in headers {
            for (key, value) in header {
                copy.updateValue(value, forKey: key)
            }
        }
        return copy
    }
}
