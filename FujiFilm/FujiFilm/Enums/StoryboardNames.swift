//  StoryboardNames.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation
import UIKit

enum StoryBoardNames: String {
    case onboarding = "Onboarding"
    case termsOfUse = "TermsOfUse"
    case privacyPolicy = "PrivacyPolicy"
    case confirmSeedSafety = "ConfirmSeedSafety"
    case createAccount = "CreateAccount"
    case createNewPassword = "CreateNewPassword"
    case seedPhrase = "SeedPhrase"
    case welcome = "Welcome"
    case accountExists = "AccountExists"
    case restoreFromSeed = "RestoreFromSeed"
    case home = "Home"
    case welcomeHome = "WelcomeHome"
    case dashboard = "Dashboard"
    case purchasePMA = "PurchasePMA"
	case wallet = "Wallet"
	case transactionHistory = "TransactionHistory"
	case transactionFilter = "TransactionFilter"
	case receiveFunds = "ReceiveFunds"
	case walletSettings = "WalletSettings"
	case supportedCurrencies = "SupportedCurrencies"
	case qrCode = "QRCode"
	case sendFund = "SendFund"
	case amount = "Amount"
	case walletDetails = "WalletDetails"
}

extension StoryBoardNames {
    var controller: String {
        return rawValue + "VC"
    }

    private var controllerInstantiageErrorMessage: String {
        return "Could not instantiate controller. Please check storyboard identifier"
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

    func instatiateControllerWithIdentifier(name: String) -> UIViewController {
        let storyboard = UIStoryboard(
            name: rawValue,
            bundle: nil
        )

        let controller = storyboard.instantiateViewController(withIdentifier: name)
        return controller
    }
}
