//
//  Theme+Fonts.swift
//  HealthyPet
//
//  Created by Kristina Motte on 06.07.2022.
//

import UIKit

extension Theme {
    struct Fonts {
        private init() {}
        
        enum OpenSans: String {
            case bold = "OpenSans-Bold"
            case regular = "OpenSans-Regular"
            case light = "OpenSans-Light"
            
            func font(size: CGFloat) -> UIFont {
                UIFont(name: rawValue, size: size)!
            }
        }
        
        static var openSansBold14: UIFont = OpenSans.bold.font(size: 14)
        static var openSansRegular14: UIFont = OpenSans.regular.font(size: 14)
    }
}
