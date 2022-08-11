//
//  TextFieldType.swift
//  HealthyPet
//
//  Created by Kristina Motte on 10/08/2022.
//

import Foundation

enum TextFieldType {
    case simple(title: String)
    case date(title: String, placeholder: String)
    
    var title: String {
        switch self {
        case .simple(let title):
            return title
        case .date(let title, _):
            return title
        }
    }
    
    var placeholder: String? {
        switch self {
        case .simple:
            return nil
        case .date(_, let placeholder):
            return placeholder
        }
    }
}
