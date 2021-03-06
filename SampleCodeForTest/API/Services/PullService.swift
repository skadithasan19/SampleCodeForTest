//
//  PullService.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation
import Combine

protocol PullService {
    var apiSession: APIService { get }
    func getPulls() -> AnyPublisher<[Pull], APIError>
}

extension PullService {
    func getPulls() -> AnyPublisher<[Pull], APIError> {
        return apiSession.request(with: MEEndpoint.pulls)
            .eraseToAnyPublisher()
    }
}
