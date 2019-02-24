//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class ForgotPasswordViewController: FujiFilmViewController {
    @IBOutlet var emailTextField: FujiFilmTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        [emailTextField].forEach {
            $0?.addBottomBorderWithColor(color: UIColor.gray, width: 0.5)
        }
    }

    @IBAction func submitAction(_: FujiFilmButton) {
        showSideMenu()
    }
}
