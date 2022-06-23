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
    let headers: Headers?
    private(set) var validations: [Validation]

    init(url: URL, method: Method, body: Data? = nil, queryItems: [URLQueryItem] = [], headers: Headers?, validations: [Validation] = []) {
        self.url = url
        self.method = method
        self.body = body
        self.queryItems = queryItems
        self.headers = headers
        self.validations = validations
    }
}

// MARK: - URL Request conversion
extension Request {
    /// Convert `Request` instance to `URLRequest`
    var asURLRequest: URLRequest {
        var request = URLRequest(url: url.with(queryItems: queryItems))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}

// MARK: - Validation
extension Request {
    enum ValidationResult {
        case success
        case error(APIError.Code)
    }

    enum Validation {
        typealias ValidateRequest = (URLRequest) -> ValidationResult
        typealias ValidateResponse = (Data?, URLResponse?, Error?) -> ValidationResult

        case request(ValidateRequest)
        case response(ValidateResponse)
    }

    /// Validates that response is an instance of `HTTPURLResponse` and has acceptable status code.
    /// Throws `APIError.unexpectedStatusCode` if validation is not passed.
    ///
    /// - Parameters:
    ///   - acceptableStatusCodes: the sequence of acceptable HTTP status codes, ex. 200..<300
    ///   - errorsByStatusCode: status codes that need to throw custom errors. Takes priority over `acceptableStatusCodes`
    /// - Returns: An instance of `Request` with validation added
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S, errorsByStatusCode: [Int: APIError.Code] = [:]) -> Request where S.Iterator.Element == Int {
        let validation: Validation = .response { _, response, _ in
            guard let response = response as? HTTPURLResponse else {
                return .error(.failedRequest)
            }

            if let error = errorsByStatusCode[response.statusCode] {
                return .error(error)
            }

            if !acceptableStatusCodes.contains(response.statusCode) {
                return .error(.unexpectedStatusCode(response.statusCode))
            }

            return .success
        }
        validations.append(validation)
        return self
    }

    /// Performs health check on data, response and error
    func validateRequestSucceeded() -> Request {
        let validation: Validation = .response { data, response, error in
            if let error = error {
                if (error as? URLError)?.code == URLError.notConnectedToInternet {
                    return .error(.noInternetConnection)
                }
                return .error(.URLSessionError(error))
            } else if !(response is HTTPURLResponse) || data == nil {
                return .error(.failedRequest)
            }
            return .success
        }
        validations.append(validation)
        return self
    }

    /// Default validations (valid token, response, status code)
    func withDefaultValidations() -> Request {
        self.validateRequestSucceeded()
            .validate(statusCode: 200..<300, errorsByStatusCode: [400: .badRequest])
    }

    /// Validate request has http body
    func validateHasBody() -> Request {
        let validation: Validation = .request { request in
            if request.httpBody == nil {
                return .error(.serializationError)
            }
            return .success
        }
        validations.append(validation)
        return self
    }
}
