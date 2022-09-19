//
//  HomeEmptyType.swift
//  HealthyPet
//
//  Created by Kristina Motte on 26/09/2022.
//

import Foundation

enum HomeEmptyType {
    case loading
    case empty
    
    var isAnimationViewHidden: Bool {
        switch self {
        case .loading:
            return false
        case .empty:
            return true
        }
    }
    
    var isImageHidden: Bool {
        switch self {
        case .loading:
            return true
        case .empty:
            return false
        }
    }
    
    var text: String {
        switch self {
        case .loading:
            return "Please wait little bit until we gather all the data"
        case .empty:
            return "No results have found"
        }
    }
}
