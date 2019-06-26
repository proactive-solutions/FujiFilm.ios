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

    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard let _ = parent else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
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
    func showCourses() -> CoursesViewController {
        let storyboardName = StoryBoardNames.Courses

        guard let controller = storyboardName.instatiateController() as? CoursesViewController else {
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
    func showQRScanResult(_ result: String, event: EventList.Result) -> QRScanResultViewController {
        let storyboardName = StoryBoardNames.QRScanResult

        guard let controller = storyboardName.instatiateController() as? QRScanResultViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.data = (result, event)

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func showWarranty(_: String) -> WarrantyViewController {
        let storyboardName = StoryBoardNames.Warranty

        guard let controller = storyboardName.initialController() as? WarrantyViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func showWarrantySearch() -> WarrantySearchViewController {
        let storyboardName = StoryBoardNames.WarrantySearch

        guard let controller = storyboardName.initialController() as? WarrantySearchViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func showWarrantySearchResultViewController() -> WarrantySearchResultViewController {
        let storyboardName = StoryBoardNames.WarrantySearchResult

        guard let controller = storyboardName.initialController() as? WarrantySearchResultViewController else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func showProductDetailsController(details: [(title: String, subTitle: String)]) -> ProductDetailsController {
        let storyboardName = StoryBoardNames.ProductDetails

        guard let controller = storyboardName.initialController() as? ProductDetailsController else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.details = details

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    @discardableResult
    func showAttendanceController(event: EventList.Result) -> AttendenceViewController {
        let storyboardName = StoryBoardNames.Attendence

        guard let controller = storyboardName.initialController() as? AttendenceViewController else {
            fatalError(controllerCastingErrorMessage)
        }
        controller.eventDetails = event

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    func logout() {
        UserDefaults.standard.userDetails = nil
        let storyboardName = StoryBoardNames.login
        let controller = storyboardName.initialController()
        AppDelegate.shared.window?.rootViewController = controller
    }

    @objc
    func showSideMenu() {
        guard let menuLeft = SideMenuManager.default.menuLeftNavigationController else { return }
        present(menuLeft, animated: true, completion: nil)
    }
}
