//
//  Reusable.swift
//  HealthyPet
//
//  Created by Kristina Motte on 15/09/2022.
//

import UIKit

// Base reusable protocol
protocol Reusable {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension Reusable {
    static var identifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

protocol ReusableTableCell: Reusable {}
protocol ReusableCollectionCell: Reusable {}
protocol ReusableHeader: Reusable {}

extension ReusableTableCell {
    static func register(in tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}

extension ReusableCollectionCell {
    static func register(in collectionView: UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension ReusableHeader {
    static func register(in tableView: UITableView) {
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
