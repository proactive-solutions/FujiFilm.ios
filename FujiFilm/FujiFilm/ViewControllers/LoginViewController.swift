//
//  ViewController.swift
//  FujiFilm
//
//  Created by Pawan Sharma on 24/02/19.
//  Copyright © 2019 Pawan Sharma. All rights reserved.
//

import UIKit

final class LoginViewController: FujiFilmViewController {
    @IBOutlet var emailTextField: FujiFilmTextField!
    @IBOutlet var passwordTextField: FujiFilmTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        [emailTextField, passwordTextField].forEach {
            $0?.addBottomBorderWithColor(color: UIColor.gray, width: 0.5)
        }
    }

    @IBAction func loginAction(_: FujiFilmButton) {
        if emailTextField.text?.trimmed.count == 0 || passwordTextField.text?.trimmed.count == 0 {
            view.show(error: "Please enter your email address and password")
            return
        }

        view.showLoader()
        var params = [String: String]()
        params["email"] = emailTextField.text
        params["password"] = passwordTextField.text

        APIManager().request(
            path: .login,
            method: .post,
            parameters: params,
            headers: nil,
            success: { [weak self] (data: Data, _: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let error = try? JSONDecoder().decode(APIError.self, from: data) {
                    self.view.show(error: error.message)
                } else if let user = try? JSONDecoder().decode(UserDetails.self, from: data) {
                    UserDefaults.standard.userDetails = user
                    self.showDashboard()
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }

    @IBAction func forgotPasswordAction(_: FujiFilmButton) {
        showForgotPassword()
    }
}
