//
//  HealthyTextField.swift
//  HealthyPet
//
//  Created by Kristina Motte on 10/08/2022.
//

import UIKit

class HealthyTextField: UIView {
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    var isEmpty: Bool {
        textField.text == nil || textField.text?.isEmpty == true
    }
    
    func configure(with type: TextFieldType) {
        placeholderLabel.text = type.title
        
        if let placeholder = type.placeholder {
            textField.text = placeholder
            textField.textColor = Theme.Colors.placeholderGrey
        } else {
            textField.textColor = Theme.Colors.black
        }
    }
    
    private func configureUI() {
        placeholderLabel.font = Theme.Fonts.openSansLight12
        placeholderLabel.textColor = Theme.Colors.black
        
        textField.layer.cornerRadius = Theme.Constants.cornerRadius
        textField.layer.borderWidth = Theme.Constants.defaultBorderWidth
        textField.layer.borderColor = Theme.Colors.mainGrey.cgColor
        textField.tintColor = Theme.Colors.rose
        textField.font = Theme.Fonts.openSansLight12
        textField.textColor = Theme.Colors.black
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.delegate = self
    }
}

extension HealthyTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.textColor == Theme.Colors.placeholderGrey {
            textField.textColor = Theme.Colors.black
            textField.text = ""
        }
        return true
    }
    
    
}
