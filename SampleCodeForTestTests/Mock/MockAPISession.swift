//
//  MockAPISession.swift
//  SampleCodeForTestUITests
//
//  Created by Adit Hasan on 5/20/21.
//

import Foundation
@testable import SampleCodeForTest

class MockURLSession: URLSession {

    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
