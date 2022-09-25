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
    
    func addChildViewController(_ child: UIViewController, containerView: UIView, pinToEdges: Bool = true) {
        child.willMove(toParent: nil)

        addChild(child)

        containerView.addSubview(child.view)

        if pinToEdges {
            child.view.translatesAutoresizingMaskIntoConstraints = false
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            child.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            child.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        }

        child.didMove(toParent: self)
    }
}
