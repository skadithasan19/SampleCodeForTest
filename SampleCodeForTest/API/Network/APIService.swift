//
//  APIService.swift
//  honeybee-ios
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation
import Combine
import UIKit

protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}
