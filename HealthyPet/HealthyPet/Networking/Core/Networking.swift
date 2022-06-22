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
        
        let task = session.dataTask(with: urlRequest) { [callbackQueue] data, response, error in
            guard let data = data, error == nil else {
                callbackQueue.async {
                    completion(.error(error ?? NSError(domain: "", code: 403)))
                }
                return
            }
            
            callbackQueue.async {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
