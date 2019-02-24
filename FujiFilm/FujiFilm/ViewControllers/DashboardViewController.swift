//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class DashboardViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var menuTableView: UITableView!

    private let menuTitles: [String] = [
        "Workshop",
        "Loan Program",
        "Warranty",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.dashboad)
        menuTableView.calculateCellHeight(estimatedHeight: 80.0)
        menuTableView.hideEmptyAndExtraRows()
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return menuTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.dashboad.rawValue,
            for: indexPath
        ) as? DashboardCell else { return DashboardCell() }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            showWorkshop()
        } else if indexPath.row == 1 {
            showWorkshop()
        } else if indexPath.row == 2 {
            showWorkshop()
        }
    }
}
