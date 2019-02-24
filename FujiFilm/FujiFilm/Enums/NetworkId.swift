//  NetworkId.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

enum NetworkId: Int {
    case mainNet = 1
    case testNet = 3
}

extension NetworkId {
    var description: String {
        switch self {
        case .mainNet:
            return "mainnet"

        case .testNet:
            return "testnet"
        }
    }
}
