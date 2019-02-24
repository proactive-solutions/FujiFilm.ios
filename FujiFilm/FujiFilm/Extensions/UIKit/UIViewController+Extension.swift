//  UIViewController+Extension.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import SideMenu
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

    @discardableResult
    func showWorkshop() -> WorkshopViewController {
        let storyboardName = StoryBoardNames.workshop

        guard let controller = storyboardName.instatiateController() as? WorkshopViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func showDashboard() -> DashboardViewController {
        let storyboardName = StoryBoardNames.dashboard

        guard let controller = storyboardName.instatiateController() as? DashboardViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.setViewControllers([controller], animated: true)
        return controller
    }

    @discardableResult
    func showQRScanResult(_ result: String) -> QRScanResultViewController {
        let storyboardName = StoryBoardNames.QRScanResult

        guard let controller = storyboardName.instatiateController() as? QRScanResultViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.qrResult = result

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @objc
    func showSideMenu() {
        guard let menuLeft = SideMenuManager.default.menuLeftNavigationController else { return }
        present(menuLeft, animated: true, completion: nil)
    }
}
