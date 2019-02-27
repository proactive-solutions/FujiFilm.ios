//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class MenuHeaderView: UITableViewHeaderFooterView {
    @IBOutlet var nameLabel: FujiFilmLabel!
    @IBOutlet var locationlabel: FujiFilmLabel!
}

final class LeftMenuViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var leftmenuTAbleView: UITableView!
    @IBOutlet private var headerView: MenuHeaderView!

    private lazy var menus: [StoryBoardNames] = [
        StoryBoardNames.dashboard,
        StoryBoardNames.Warranty,
        StoryBoardNames.Warranty,
        StoryBoardNames.Warranty,
    ]

    private let menuTitles: [String] = [
        "Workshops",
        "Loan Program",
        "Warranty",
        // "Change Password",
        "Logout",
    ]

    private let menuicons: [UIImage] = [
        #imageLiteral(resourceName: "Workshop_icon"),
        #imageLiteral(resourceName: "loan_program_icon"),
        #imageLiteral(resourceName: "warranty_icon"),
        // #imageLiteral(resourceName: "change_password_icon"),
        #imageLiteral(resourceName: "logout_icon"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        leftmenuTAbleView.registerNib(.leftMenuCell)
        leftmenuTAbleView.calculateCellHeight(estimatedHeight: 80.0)
        leftmenuTAbleView.hideEmptyAndExtraRows()
        leftmenuTAbleView.tableHeaderView = headerView
        leftmenuTAbleView.sectionHeaderHeight = 100.0

        if let details = UserDefaults.standard.userDetails {
            headerView.nameLabel.text = details.result.fullName
            headerView.locationlabel.text = details.result.fldCity
        }

        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let details = UserDefaults.standard.userDetails {
            headerView.nameLabel.text = details.result.fullName
            headerView.locationlabel.text = details.result.fldCity
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
        cell.menuIconImageView.image = menuicons[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row <= 2 {
            let controller = menus[indexPath.row].initialController()
            navigationController?.pushViewController(controller, animated: true)
            controller.title = menuTitles[indexPath.row]
        } else {
            dismiss(animated: false, completion: nil)
            logout()
        }
    }
}
