//  UITableView+Extension.swift
//  PumaPay
//  Copyright © 2018 PumaPay. All rights reserved.

import Foundation
import UIKit

extension UITableView {
    /// Register a XIB file with UITableView. XIB file name is used as reuse identifier so keep in mind to use the file name as reuse identifier.
    /// - Parameter nibName: Name of the XIB file
    @discardableResult func registerNib(_ nibName: TableViewCellXibs) -> UITableView {
        let cellNib = UINib(nibName: nibName.rawValue, bundle: nil)
        register(cellNib, forCellReuseIdentifier: nibName.rawValue)
        return self
    }

    /// Make a UItableViewCell height automatic based on the AutoLayouts used.
    /// - Parameter expectedHeight: Estimated height for the row
    @discardableResult func calculateCellHeight(estimatedHeight expectedHeight: CGFloat) -> UITableView {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = expectedHeight
        return self
    }

    /// Hides extra rows created by UIKit with no data to display.
    @discardableResult func hideEmptyAndExtraRows() -> UITableView {
        tableFooterView = UIView()
        return self
    }
}
