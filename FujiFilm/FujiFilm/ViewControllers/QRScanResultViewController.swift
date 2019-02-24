//
//  QRScanResultViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 25/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

class QRScanResultViewController: FujiFilmViewController {
    @IBOutlet var qrResultLabel: FujiFilmLabel!

    var qrResult = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        qrResultLabel.text = qrResult
    }
}
