//
//  API.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

final class API {
    typealias APICompletion<T> = ((APIResult<T>) -> Void)
    
    static let shared = API()
    private init() {}

    private lazy var networking: NetworkingType = networkingFactory.makeNetworking()
    private var networkingFactory: NetworkingFactory = NetworkingFactoryImpl()

    // MARK: - Execute network request
    func execute<ResponseType>(_ request: Request,
                               parse: @escaping (Data) throws -> ResponseType,
                               cache: ((Data) -> Void)? = nil,
                               completion: @escaping APICompletion<ResponseType>) {
        networking.sendRequest(request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try parse(data)
                    cache?(data)
                    completion(.success(response))
                } catch let error {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
