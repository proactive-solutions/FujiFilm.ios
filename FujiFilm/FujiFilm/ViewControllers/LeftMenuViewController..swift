//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class LeftMenuViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var leftmenuTAbleView: UITableView!
    @IBOutlet private var headerView: UITableViewHeaderFooterView!

    private let menuTitles: [String] = [
        "Workshop",
        "Loan Program",
        "Warranty",
        "Change Password",
        "Logout",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        leftmenuTAbleView.registerNib(.leftMenuCell)
        leftmenuTAbleView.calculateCellHeight(estimatedHeight: 80.0)
        leftmenuTAbleView.hideEmptyAndExtraRows()
        leftmenuTAbleView.tableHeaderView = headerView
        leftmenuTAbleView.sectionHeaderHeight = 300.0
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return menuTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.leftMenuCell.rawValue,
            for: indexPath
        ) as? FujiFilmLeftMenuCell else { return FujiFilmLeftMenuCell() }

        cell.menuTitleLabel.text = menuTitles[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
