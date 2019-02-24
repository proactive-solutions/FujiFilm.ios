//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class LoginViewController: FujiFilmViewController {

    @IBOutlet weak var emailTextField: FujiFilmTextField!
    @IBOutlet weak var passwordTextField: FujiFilmTextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        [emailTextField, passwordTextField].forEach {
            $0?.addBottomBorderWithColor(color: UIColor.gray, width: 0.5)
        }
    }

    @IBAction func loginAction(_ sender: FujiFilmButton) {

    }

    @IBAction func forgotPasswordAction(_ sender: FujiFilmButton) {

    }
}
