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
                               cache: ((Data) -> Void)? = nil) async -> APIResult<ResponseType> {
        return await withCheckedContinuation { continuation in
            networking.sendRequest(request) { result in
                switch result {
                case .success(let data):
                    do {
                        let response = try parse(data)
                        cache?(data)
                        continuation.resume(returning: .success(response))
                    } catch let error {
                        continuation.resume(returning: .error(error))
                    }
                case .error(let error):
                    continuation.resume(returning: .error(error))
                }
            }
        }
    }
}
