//
//  UIButton+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 25/09/2022.
//

import UIKit

extension UIButton {
    func showSpinner(tintColor: UIColor? = nil) {
        DispatchQueue.main.async {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.tag = 1
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.color = tintColor
            
            if let superview = self.superview {
                superview.addSubview(spinner)
                spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            }
            spinner.startAnimating()
            
            if let titleLabel = self.titleLabel {
                titleLabel.alpha = 0
            }
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            if let spinner = self.superview?.viewWithTag(1) {
                spinner.removeFromSuperview()
            }

            if let titleLabel = self.titleLabel {
                titleLabel.alpha = 1
            }
        }
    }
}
