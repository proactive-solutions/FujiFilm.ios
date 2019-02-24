//  NetworkResult.swift
//  PumaPay
//  Copyright © 2019 PumaPay. All rights reserved.

import Foundation

enum NetworkResult<String> {
    case success
    case failure(String)
}
