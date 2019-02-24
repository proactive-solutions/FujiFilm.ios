//  StoryboardNames.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import UIKit

enum StoryBoardNames: String {
    case login = "Login"
    case forgotPassword = "ForgotPassword"
}

extension StoryBoardNames {
    var controller: String {
        return rawValue + "ViewController"
    }

    private var initilControllerNotSet: String {
        return "InitilControllerNotSet in storyboard"
    }

    private var controllerInstantiageErrorMessage: String {
        return "Could not instantiate controller. Please check storyboard identifier"
    }

    func initialController() -> UIViewController {
        let storyboard = UIStoryboard(
            name: rawValue,
            bundle: nil
        )

        guard let controller = storyboard.instantiateInitialViewController() else {
            fatalError(initilControllerNotSet)
        }
        return controller
    }

    func instatiateController() -> UIViewController {
        let storyboard = UIStoryboard(
            name: rawValue,
            bundle: nil
        )

        let controller = storyboard.instantiateViewController(
            withIdentifier: self.controller
        )
        return controller
    }
}
