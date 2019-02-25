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
        if emailTextField.text?.trimmed.count == 0 {
            view.show(error: "Please enter your email address")
            return
        }

        view.showLoader()
        var params = [String: String]()
        params["email"] = emailTextField.text

        APIManager().request(
            path: APIPaths.forgotPassword,
            method: .post,
            extraParams: nil,
            parameters: params,
            headers: nil,
            success: { [weak self] (data: Data, code: Int) in
                guard let self = self else { return }
                self.view.hideLoader()
                if let response = try? JSONDecoder().decode(APIError.self, from: data) {
                    if code == 200 {
                        self.view.show(success: response.message)
                    } else {
                        self.view.show(error: response.message)
                    }
                }
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.view.hideLoader()
                self.view.show(error: error.localizedDescription)
        })
    }
}
