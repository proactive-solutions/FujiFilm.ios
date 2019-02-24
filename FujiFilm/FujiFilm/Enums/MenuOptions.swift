//
//  MenuOptions.swift
//  PumaPay
//
//  Created by rails on 01/02/19.
//  Copyright © 2019 PumaPay. All rights reserved.
//

import Foundation
enum MenuOption: String, CustomStringConvertible {

    case WALLET
    case SEND_FUNDS
    case RECEIVE_FUNDS
    case RE_PAYMENTS
    case CNC_CONVERT
    case TRANS_HISTORY
    case WLT_SETTINGS
    case GEN_SETTINGS
    case PUSH_NOTIFICATIONS
    case FAQ
    case T_AND_C
    case P_AND_P
    case LOGOUT

    var description: String {
        switch self {
        case .WALLET: return "Wallet"
        case .SEND_FUNDS: return "Send Funds"
        case .RECEIVE_FUNDS: return "Receive Funds"
        case .RE_PAYMENTS: return "Recurring Payments"
        case .CNC_CONVERT: return "Currency Convert"
        case .TRANS_HISTORY: return "Transaction History"
        case .WLT_SETTINGS: return "Wallet Settings"
        case .GEN_SETTINGS: return "General Settings"
        case .PUSH_NOTIFICATIONS: return "Push Notifications"
        case .FAQ: return "FAQ"
        case .T_AND_C: return "Terms & Conditions"
        case .P_AND_P: return "Privacy Policy"
        case .LOGOUT: return "Log Out"
        }
    }
}
