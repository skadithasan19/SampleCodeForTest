//
//  APISession.swift
//  honeybee-ios
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation
import Combine
import UIKit

struct APISession: APIService {
    
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print(builder.urlRequest.url?.absoluteURL as Any)
        return URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { err in .unknown }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError { err in
                                .decodingError(err.localizedDescription)
                            }.eraseToAnyPublisher()
                    } else {
                        return Fail(error: APIError.httpError(response.statusCode)).eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
