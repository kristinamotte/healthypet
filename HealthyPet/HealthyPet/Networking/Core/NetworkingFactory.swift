//
//  NetworkingFactory.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

protocol NetworkingFactory {
    func makeNetworking() -> NetworkingType
}

struct NetworkingFactoryImpl: NetworkingFactory {
    func makeNetworking() -> NetworkingType {
        Networking(
            callbackQueue: .main
        )
    }
}
