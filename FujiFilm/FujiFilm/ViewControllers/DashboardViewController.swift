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
        #imageLiteral(resourceName: "Courses"),
        #imageLiteral(resourceName: "warranty_image"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.dashboad)
        menuTableView.calculateCellHeight(estimatedHeight: 80.0)
        menuTableView.hideEmptyAndExtraRows()

        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "toggle_icon"),
            style: .plain,
            target: self,
            action: #selector(showSideMenu)
        )

        let iv = UIImageView.init(image: #imageLiteral(resourceName: "dashboard_logo"))
        iv.contentMode = .scaleAspectFit
        iv.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: iv)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = nil
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
            showCourses()
        } else if indexPath.row == 2 {
            showWarrantySearch()
        }
    }
}
