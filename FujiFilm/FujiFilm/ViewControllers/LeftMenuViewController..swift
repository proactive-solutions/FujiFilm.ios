//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class MenuHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var nameLabel: FujiFilmLabel!
    @IBOutlet weak var locationlabel: FujiFilmLabel!
}

final class LeftMenuViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var leftmenuTAbleView: UITableView!
    @IBOutlet private var headerView: MenuHeaderView!

    private lazy var menus: [StoryBoardNames] = [
        StoryBoardNames.dashboard,
        StoryBoardNames.workshop,
        StoryBoardNames.dashboard,
        StoryBoardNames.workshop,
    ]

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

        if let details = UserDefaults.standard.userDetails {
            self.headerView.nameLabel.text = details.result.fldFirstname + details.result.fldFamilyname
            self.headerView.locationlabel.text = details.result.fldAddress + details.result.fldAddress1
        }
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
        if indexPath.row <= 3 {
            let controller = menus[indexPath.row].initialController()
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            UserDefaults.standard.userDetails = nil
            self.logout()
        }
    }
}
