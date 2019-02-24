//  ETHMethods.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

public enum ETHMethods: String {
    case getBalance = "eth_getBalance"
    case getTransactionCount = "eth_getTransactionCount"
    case gasPrice = "eth_gasPrice"
    case estimateGas = "eth_estimateGas"
    case sendRawTransaction = "eth_sendRawTransaction"
}
