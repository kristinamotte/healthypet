//
//  APIError.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import Foundation

struct APIError: Swift.Error {
    let code: Code
    let request: Request
    
    enum Code: Swift.Error {
        case badRequest
        case failedRequest
        case unexpectedStatusCode(Int)
        case invalidResponse(description: String)
        case serializationError
        case URLSessionError(Swift.Error)
        case noInternetConnection
    }
}
