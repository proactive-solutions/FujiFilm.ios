//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class ProductDetailsController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var menuTableView: UITableView!

    var details: [(title: String, subTitle: String)]? {
        didSet {
            menuTableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.ProductWarrantyCell)
        menuTableView.calculateCellHeight(estimatedHeight: 80.0)
        menuTableView.hideEmptyAndExtraRows()

        menuTableView.addExtraScrollAt(top: 20.0)
        menuTableView?.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Warranty"
    }


    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return details?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.ProductWarrantyCell.rawValue,
            for: indexPath
        ) as? ProductWarrantyCell else { return WarrantyCell() }

        if let detail = details?[indexPath.row] {
            cell.titleLabelText.text = detail.title
            cell.subTitleLabelText.text = detail.subTitle
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
