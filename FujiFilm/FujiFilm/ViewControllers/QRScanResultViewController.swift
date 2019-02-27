//
//  QRScanResultViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 25/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

class QRScanResultViewController: FujiFilmViewController {
    @IBOutlet private var qrResultLabel: FujiFilmLabel!
    @IBOutlet private var qrScanMessageLabel: FujiFilmLabel!
    @IBOutlet private var nameLabel: FujiFilmLabel!
    @IBOutlet private var cityLabel: FujiFilmLabel!
    @IBOutlet private var dateLabel: FujiFilmLabel!
    @IBOutlet private var timeLabel: FujiFilmLabel!

    var data: (qrResult: String, event: EventList.Result)?

    override func viewDidLoad() {
        super.viewDidLoad()
        sendQRResultToServer()
    }

    @IBAction func continueAction(_: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

    private func sendQRResultToServer() {
        guard let _data = self.data, let user = UserDefaults.standard.userDetails else { return }
        view.showLoader()
        var params: [String: String] = [:]
        params["qr_code"] = _data.qrResult
        params["distributor_id"] = _data.event.fldEventDid
        params["event_id"] = _data.event.fldEventID
        params["user_id"] = user.result.fldDid

        APIManager().request(
            path: .scanQrCodeByDistributor,
            method: .post,
            extraParams: nil,
            parameters: params,
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let success = try? JSONDecoder().decode(QRSaveSuccess.self, from: data) {
                    self.view.show(success: success.message)
                    self.nameLabel.text = "\(success.result.user.fldFullname)"
                    self.cityLabel.text = success.result.user.fldCity
                    self.dateLabel.text = success.result.user.date
                    self.timeLabel.text = success.result.user.startTime
                } else if let fail = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: fail.message)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) { [weak self] in
                        guard let self = self else { return }
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }
}
