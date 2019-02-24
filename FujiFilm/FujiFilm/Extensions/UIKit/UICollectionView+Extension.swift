//  UITableView+Extension.swift
//  Howdoo
//  Copyright © 2018 PumaPay. All rights reserved.

import Foundation
import UIKit

extension UICollectionView {
    /// Register a XIB file with UITableView. XIB file name is used as reuse identifier so keep in mind to use the file name as reuse identifier.
    /// - Parameter nibName: Name of the XIB file
    @discardableResult func registerNib(_ cell: CollectionViewCellXibs) -> UICollectionView {
        let cellNib = UINib(nibName: cell.rawValue, bundle: nil)
        register(cellNib, forCellWithReuseIdentifier: cell.rawValue)
        return self
    }
}
