//
//  EndPoint.swift
//  honeybee-ios
//
//  Created by Md Adit Hasan on 11/10/20.
//

import Foundation

enum MEEndpoint {
    case pulls
}
 
extension MEEndpoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .pulls:
            guard let url = URL(string: URLS.pulls) else { preconditionFailure("Invalid URL format") }
            let request = URLRequest(url: url)
            return request
        }
    }
}
