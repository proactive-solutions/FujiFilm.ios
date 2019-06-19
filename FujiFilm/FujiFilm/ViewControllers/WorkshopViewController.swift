//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import AVFoundation
import QRCodeReader
import UIKit

final class WorkshopViewController: FujiFilmViewController, UITableViewDataSource, UITableViewDelegate, QRCodeReaderViewControllerDelegate {
    @IBOutlet private var menuTableView: UITableView!

    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }

        return QRCodeReaderViewController(builder: builder)
    }()

    private var evnetsEventList: [EventList.Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.workshop)
        menuTableView.calculateCellHeight(estimatedHeight: 80.0)
        menuTableView.hideEmptyAndExtraRows()

        menuTableView.addExtraScrollAt(top: 20.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWorkshop()
    }

    private func getWorkshop() {
        guard let user = UserDefaults.standard.userDetails else { return }
        view.showLoader()
        APIManager().request(
            path: APIPaths.getDistributorWorkshop,
            method: .post,
            extraParams: nil,
            parameters: ["distributor_id": user.result.fldDid],
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let list = try? JSONDecoder().decode(EventList.self, from: data) {
                    self.evnetsEventList.removeAll()
                    self.evnetsEventList = list.result
                    self.menuTableView.reloadData()
                } else if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return evnetsEventList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCellXibs.workshop.rawValue,
            for: indexPath
        ) as? WorkshopCell else { return WorkshopCell() }

        let result = evnetsEventList[indexPath.row]

        cell.scan = { [weak self] in
            self?.scanQR(event: result)
        }

        cell.display(result: result)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    private func scanQR(event: EventList.Result) {
        // self.showQRScanResult("ABC123", event: event)

        readerVC.delegate = self

        // Or by using the closure pattern
        readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
            if let _result = result?.value {
                self?.showQRScanResult(_result, event: event)
            }
        }

        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }

    func reader(_ reader: QRCodeReaderViewController, didScanResult _: QRCodeReaderResult) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }

    // This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    // By pressing on the switch camera button
    func reader(_: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        print("Switching capture to: \(newCaptureDevice.device.localizedName)")
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }
}
