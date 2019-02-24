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

    private let menuTitles: [String] = [
        "Workshop",
        "Loan Program",
        "Warranty",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.registerNib(.workshop)
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
            withIdentifier: TableViewCellXibs.workshop.rawValue,
            for: indexPath
        ) as? WorkshopCell else { return WorkshopCell() }

        cell.scan = { [weak self] in
            self?.scanQR()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    private func scanQR() {
        readerVC.delegate = self

        // Or by using the closure pattern
        readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
            if let _result = result?.value {
                self?.showQRScanResult(_result)
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
