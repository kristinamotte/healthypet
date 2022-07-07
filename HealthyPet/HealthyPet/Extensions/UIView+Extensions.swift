//
//  UIView+Extensions.swift
//  HealthyPet
//
//  Created by Kristina Motte on 06.07.2022.
//

import UIKit

extension UIView {
    class func instanceFromNib<T: UIView>(with owner: Any? = nil) -> T {
        let nibName = String(describing: self).components(separatedBy: ".").last ?? ""
        guard let view = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil)?.first as? T else {
            return T(frame: CGRect.zero)
        }
        return view
    }

    func add(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
