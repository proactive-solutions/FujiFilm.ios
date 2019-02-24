//  UIViewController+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import UIKit

// MARK: - Share

extension UIViewController {
    func share(items: [Any]) {
        let ac = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        present(ac, animated: true, completion: nil)
    }
}

// MARK: - Navigation

extension UIViewController {
    private var controllerCastingErrorMessage: String {
        return "Could not type cast controller"
    }

    @discardableResult
    func showForgotPassword() -> ForgotPasswordViewController {
        let storyboardName = StoryBoardNames.forgotPassword

        guard let controller = storyboardName.instatiateController() as? ForgotPasswordViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }
}
