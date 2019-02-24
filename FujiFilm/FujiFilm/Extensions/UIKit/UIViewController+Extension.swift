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

    func showTermsOfUse() {
        let storyboardName = StoryBoardNames.termsOfUse
        guard let controller = storyboardName.instatiateController() as? TermsOfUseVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showPrivacyPolicy() {
        let storyboardName = StoryBoardNames.privacyPolicy

        guard let controller = storyboardName.instatiateController() as? PrivacyPolicyVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showWelcomeController() {
        let storyboardName = StoryBoardNames.welcome

        guard let controller = storyboardName.instatiateController() as? WelcomeVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.setViewControllers([controller], animated: false)
    }

    func showDashboardVC(privateKey _: String) {
        let storyboardName = StoryBoardNames.dashboard

        guard let controller = storyboardName.instatiateController() as? DashboardVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.setViewControllers([controller], animated: true)
    }

    func showLoginController() {
        let storyboardName = StoryBoardNames.accountExists

        guard let controller = storyboardName.instatiateController() as? AccountExistsVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showRestoreFromSeedController() {
        let storyboardName = StoryBoardNames.restoreFromSeed

        guard let controller = storyboardName.instatiateController() as? RestoreFromSeedVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showSeedPhraseController(password: String) {
        let storyboardName = StoryBoardNames.seedPhrase

        guard let controller = storyboardName.instatiateController() as? SeedPhraseVC else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.password = password

        navigationController?.pushViewController(controller, animated: true)
    }

    func showCreateNewPasswordController(mnemonic: String) {
        let storyboardName = StoryBoardNames.createNewPassword

        guard let controller = storyboardName.instatiateController() as? CreateNewPasswordVC else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.mnemonic = mnemonic

        navigationController?.pushViewController(controller, animated: true)
    }

    @discardableResult func showSeedConfirmation(
        transitionStyle: UIModalTransitionStyle = .crossDissolve,
        presentationStyle _: UIModalPresentationStyle = .overCurrentContext
    )
        -> ConfirmSeedSafetyVC {
        let storyboardName = StoryBoardNames.confirmSeedSafety

        guard let controller = storyboardName.instatiateController() as? ConfirmSeedSafetyVC else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.modalTransitionStyle = transitionStyle
        controller.modalPresentationStyle = .overCurrentContext

        present(controller, animated: true, completion: nil)

        return controller
    }

    func showCreateAccountController() {
        let storyboardName = StoryBoardNames.createAccount

        guard let controller = storyboardName.instatiateController() as? CreateAccountVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    @discardableResult func transactionFiltersController(
        sourceview: UIView,
        presentor: UIPopoverPresentationControllerDelegate
    ) -> TransactionFilterVC {
        let storyboardName = StoryBoardNames.transactionFilter

        guard let controller = storyboardName.instatiateController() as? TransactionFilterVC else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.modalPresentationStyle = .popover

        if let pctrl = controller.popoverPresentationController {
            pctrl.sourceView = sourceview
            pctrl.sourceRect = sourceview.bounds
            pctrl.delegate = presentor
            controller.preferredContentSize = CGSize(width: 280, height: 320)
            pctrl.permittedArrowDirections = .up
            present(controller, animated: true, completion: nil)
        }

        return controller
    }

    func showPurchasePMA() {
        let storyboardName = StoryBoardNames.purchasePMA

        guard let controller = storyboardName.instatiateController() as? PMAPurchaseVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showReceiveFund() {
        let storyboardName = StoryBoardNames.receiveFunds

        guard let controller = storyboardName.instatiateController() as? ReceiveFundsVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showQRCode(_ wallet: WalletDetails) {
        let storyboardName = StoryBoardNames.qrCode

        guard let controller = storyboardName.instatiateController() as? QRCodeVC else {
            fatalError(controllerCastingErrorMessage)
        }
        controller.userWallet = wallet
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc
    func showWalletSettings() {
        let storyboardName = StoryBoardNames.walletSettings

        guard let controller = storyboardName.instatiateController() as? WalletSettingsVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showSupportedCurrencies() {
        let storyboardName = StoryBoardNames.supportedCurrencies

        guard let controller = storyboardName.instatiateController() as? SupportedCurrenciesVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    func showAddERC20Token() {}

    func showSendFund() {
        let storyboardName = StoryBoardNames.sendFund

        guard let controller = storyboardName.instatiateController() as? SendFundVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
    }

    @discardableResult func showInputAmount() -> AmountVC {
        let storyboardName = StoryBoardNames.amount

        guard let controller = storyboardName.instatiateController() as? AmountVC else {
            fatalError(controllerCastingErrorMessage)
        }

        navigationController?.pushViewController(controller, animated: true)
        return controller
    }

    func showWalletDetails(currency: CryptoCurrencies) {
        let storyboardName = StoryBoardNames.walletDetails

        guard let controller = storyboardName.instatiateController() as? WalletDetailsVC else {
            fatalError(controllerCastingErrorMessage)
        }

        controller.currency = currency

        navigationController?.pushViewController(controller, animated: true)
    }
}
