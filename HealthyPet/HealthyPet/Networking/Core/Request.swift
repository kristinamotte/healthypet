//
//  Request.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

enum Method: String {
    case GET, POST, PUT, DELETE
}

class Request {
    let url: URL
    let method: Method
    let body: Data?
    let queryItems: [URLQueryItem]

    init(url: URL, method: Method, body: Data? = nil, queryItems: [URLQueryItem] = []) {
        self.url = url
        self.method = method
        self.body = body
        self.queryItems = queryItems
    }
}

// MARK: - URL Request conversion
extension Request {
    /// Convert `Request` instance to `URLRequest`
    var asURLRequest: URLRequest {
        var request = URLRequest(url: url.with(queryItems: queryItems))
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
