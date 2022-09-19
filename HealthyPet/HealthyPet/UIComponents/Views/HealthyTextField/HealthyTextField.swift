//
//  HealthyTextField.swift
//  HealthyPet
//
//  Created by Kristina Motte on 10/08/2022.
//

import UIKit
import Veil

class HealthyTextField: UIView {
    // MARK: - Outlets
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var type: TextFieldType = .simple(title: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    var isEmpty: Bool {
        textField.text == nil || textField.text?.isEmpty == true || textField.textColor == Theme.Colors.placeholderGrey
    }
    
    var text: String {
        textField.text ?? ""
    }
    
    func configure(with type: TextFieldType) {
        self.type = type
        placeholderLabel.text = type.title
        textField.keyboardType = type.keyboardType
        
        if let placeholder = type.placeholder {
            textField.text = placeholder
            textField.textColor = Theme.Colors.placeholderGrey
        } else {
            textField.textColor = Theme.Colors.black
        }
    }
    
    func update(with text: String) {
        textField.text = text
        textField.textColor = Theme.Colors.black
    }
    
    func set(error: String) {
        errorLabel.text = error
        errorLabel.isHidden = false
    }
    
    func removeError() {
        errorLabel.isHidden = true
    }
    
    // MARK: - Private methods
    private func configureUI() {
        placeholderLabel.font = Theme.Fonts.openSansLight12
        placeholderLabel.textColor = Theme.Colors.black
        errorLabel.isHidden = true
        errorLabel.font = Theme.Fonts.openSansLight12
        errorLabel.textColor = .red
        
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
        textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }
    
    @objc private func didChangeText() {
        guard let currentText = textField.text else { return }
        
        if case .date = type {
            let dateMask = Veil(pattern: "####-##-##")
            textField.text = dateMask.mask(input: currentText, exhaustive: false)
        }
    }
}

// MARK: - UITextFieldDelegate
extension HealthyTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.textColor == Theme.Colors.placeholderGrey {
            textField.textColor = Theme.Colors.black
            textField.text = ""
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if case .date = type {
            let dateFormatter = DateFormatter.addPetDateFormatter
            if !text.isEmpty && dateFormatter.date(from: text) != nil {
                removeError()
            }
        } else if !text.isEmpty {
            removeError()
        }
    }
}
