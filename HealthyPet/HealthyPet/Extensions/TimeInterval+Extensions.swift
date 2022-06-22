//
//  TimeInterval+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import Foundation

extension TimeInterval {
    static let week: TimeInterval = TimeInterval.day * 7
    static let day: TimeInterval = TimeInterval.hour * 24
    static let hour: TimeInterval = TimeInterval.minute * 60
    static let minute: TimeInterval = 60
}
