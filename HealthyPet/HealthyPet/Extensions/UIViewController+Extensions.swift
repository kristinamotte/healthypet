//
//  UIViewController+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 19/08/2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround(shouldCancelsTouchesInView: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = shouldCancelsTouchesInView
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
