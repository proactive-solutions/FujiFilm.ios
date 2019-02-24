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

    private let menuTitles: [UIImage] = [
        #imageLiteral(resourceName: "workshop_image"),
        #imageLiteral(resourceName: "loan_program_image"),
        #imageLiteral(resourceName: "warranty_image"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.dashboad)
        menuTableView.calculateCellHeight(estimatedHeight: 80.0)
        menuTableView.hideEmptyAndExtraRows()

        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "successfully_icon"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(showSideMenu)
        )
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

        cell.logoImageView.image = menuTitles[indexPath.row]

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
