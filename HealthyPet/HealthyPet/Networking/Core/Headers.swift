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
