//
//  FilterButton.swift
//  HealthyPet
//
//  Created by Kristina Motte on 06.07.2022.
//

import UIKit

class FilterButton: UIButton {
    enum ButtonStyle: Int {
        case pressed = 0
        case notPressed = 1
    }
    
    @IBInspectable
    var style: Int {
        get {
            return buttonStyle.rawValue
        }
        set(newValue) {
            buttonStyle = ButtonStyle(rawValue: newValue) ?? .notPressed
        }
    }
    
    var buttonStyle: ButtonStyle = .notPressed {
        didSet {
            configure()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        configure()
    }
    
    // MARK: - Private methods
    private func configure() {
        layer.cornerRadius = 14
        clipsToBounds = true
        titleLabel?.font = Theme.Fonts.openSansRegular14
        
        switch buttonStyle {
        case .pressed:
            layer.borderWidth = Theme.Constants.noBorderWidth
            setTitleColor(Theme.Colors.black, for: .normal)
            backgroundColor = Theme.Colors.lightBlue
        case .notPressed:
            layer.borderWidth = Theme.Constants.defaultBorderWidth
            layer.borderColor = Theme.Colors.mainGrey.cgColor
            setTitleColor(Theme.Colors.black, for: .normal)
            backgroundColor = Theme.Colors.white
        }
    }
}
