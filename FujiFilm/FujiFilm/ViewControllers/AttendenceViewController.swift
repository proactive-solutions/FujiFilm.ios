//
//  ViewController.swift
//  StoryboardingDemo
//
//  Created by rails gr4 on 19/06/19.
//  Copyright © 2019 Deqode. All rights reserved.
//

import UIKit

class AttendenceViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private var attendenceTableView: FujiFilmTableView!

    private let cellReuseIdentifier = TableViewCellXibs.AttendenceCell.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        attendenceTableView
            .registerNib(.AttendenceCell)
            .calculateCellHeight(estimatedHeight: 80.0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier) as? AttendenceCell else {
            return AttendenceCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }
        return cell
    }
}
