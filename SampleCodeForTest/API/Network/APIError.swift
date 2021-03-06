//
//  APIError.swift
//  honeybee-ios
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation

enum APIError: Error {
    case decodingError(String)
    case httpError(Int)
    case unknown
}
