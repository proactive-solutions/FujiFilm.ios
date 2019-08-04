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

    var eventDetails: EventList.Result?
    private var absents: [Attendees.Result.Attendence]?
    private var presents: [Attendees.Result.Attendence]?
    @IBOutlet var tabMenuButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        attendenceTableView
            .registerNib(.AttendenceCell)
            .calculateCellHeight(estimatedHeight: 80.0)
            .hideEmptyAndExtraRows()

        addUnderLineLayer()

        getAttendees()
    }

    private func addUnderLineLayer() {
        tabMenuButtons.forEach {
            $0.addBottomBorderWithColor(color: .clear, width: 1.0)
        }
        tabMenuButtons?.first?.underLineColor = UIColor.blue.cgColor
    }

    @IBAction private func presentUser(_ sender: UIButton) {
        tabMenuButtons.forEach { $0.underLineColor = UIColor.clear.cgColor }
        sender.underLineColor = UIColor.blue.cgColor
    }

    @IBAction private func absentUser(_ sender: UIButton) {
        tabMenuButtons.forEach { $0.underLineColor = UIColor.clear.cgColor }
        sender.underLineColor = UIColor.blue.cgColor
    }

    @IBAction private func registeredUser(_ sender: UIButton) {
        tabMenuButtons.forEach { $0.underLineColor = UIColor.clear.cgColor }
        sender.underLineColor = UIColor.blue.cgColor
    }

    @IBAction private func waitingListUser(_ sender: UIButton) {
        tabMenuButtons.forEach { $0.underLineColor = UIColor.clear.cgColor }
        sender.underLineColor = UIColor.blue.cgColor
    }

    private func getAttendees() {
        guard let user = UserDefaults.standard.userDetails,
            let eveId = self.eventDetails?.fldEventID else { return }

        view.showLoader()
        APIManager().request(
            path: APIPaths.getWorkshopDetails,
            method: .post,
            extraParams: nil,
            parameters: [
                "distributor_id": user.result.fldDid,
                "event_id": eveId
            ],
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let details = try? JSONDecoder().decode(Attendees.self, from: data) {
                    self.absents = details.result.attendence.filter {
                        $0.status.lowercased() == "Absent".lowercased()
                    }

                    self.presents = details.result.attendence.filter {
                        $0.status.lowercased() == "Present".lowercased()
                    }

                    self.attendenceTableView.reloadData()
                } else if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    private func markPresent(data: [String: Any]) {
        view.showLoader()
        APIManager().request(
            path: APIPaths.scanQrCodeByDistributor,
            method: .post,
            extraParams: nil,
            parameters: data,
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                print(String.init(data: data, encoding: String.Encoding.utf8)!)
                self.view.hideLoader()
                if let details = try? JSONDecoder().decode(Attendees.self, from: data) {
                    self.absents = details.result.attendence.filter {
                        $0.status.lowercased() == "Absent".lowercased()
                    }

                    self.presents = details.result.attendence.filter {
                        $0.status.lowercased() == "Present".lowercased()
                    }

                    self.attendenceTableView.reloadData()
                } else if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presents?.count ?? 0
        }
        return absents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: self.cellReuseIdentifier
        ) as? AttendenceCell else {
            return AttendenceCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        }

        if indexPath.section == 0 {
            cell.markPresent = nil
            cell.markPresentButton.isHidden = true
            if let data = self.presents?[indexPath.row] {
                cell.nameLabel?.text = data.name
                cell.phoneNumberButton.setTitle(data.phone, for: .normal)
            }
        } else {
            if let data = self.absents?[indexPath.row] {
                guard let user = UserDefaults.standard.userDetails else { fatalError("user not found") }

                cell.nameLabel?.text = data.name
                cell.phoneNumberButton.setTitle(data.phone, for: .normal)
                cell.markPresentButton.isHidden = false
                cell.markPresent = { [weak self] in
                    guard let self = self else { return }

                    let apiData: [String: Any] = [
                        "qr_code": data.qrCode,
                        "distributor_id": user.result.fldDid,
                        "event_id": data.eventID,
                        "type": "S"
                    ]

                    self.markPresent(data: apiData)
                }
            } else {
                cell.markPresent = nil
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titles = ["Present", "Absent"]
        return titles[section]
    }
}
