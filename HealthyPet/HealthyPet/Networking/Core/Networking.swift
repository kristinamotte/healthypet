//
//  Networking.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

protocol NetworkingType {
    /// Execute a network request
    ///
    /// - Parameters:
    ///   - request: a request to be executed
    ///   - completion: callback method with the request result specified by a `Result` instance
    func sendRequest(_ request: Request, completion: @escaping (APIResult<Data>) -> Void)
}

/// Networking client that executes HTTP network requests
final class Networking: NSObject, NetworkingType {
    private let session: URLSession
    private let callbackQueue: DispatchQueue

    init(session: URLSession = .shared, callbackQueue: DispatchQueue) {
        self.session = session
        self.callbackQueue = callbackQueue
    }
    
    func sendRequest(_ request: Request, completion: @escaping (APIResult<Data>) -> Void) {
        let urlRequest = request.asURLRequest
        
        // validate request
        for case let .request(validation) in request.validations {
            if case let .error(error) = validation(urlRequest) {
                callbackQueue.async {
                    completion(.error(APIError(code: error, request: request)))
                }
                
                return
            }
        }

        let task = session.dataTask(with: urlRequest) { [callbackQueue] data, response, error in
            // validate response
            for case let .response(validation) in request.validations {
                if case let .error(error) = validation(data, response, error) {
                    callbackQueue.async {
                        completion(.error(APIError(code: error, request: request)))
                    }
                    
                    return
                }
            }
            
            callbackQueue.async {
                completion(.success(data ?? Data()))
            }
        }

        task.resume()
    }
}
