//
//  SampleCodeForTestTests.swift
//  SampleCodeForTestTests
//
//  Created by Adit Hasan on 5/20/21.
//

import XCTest

@testable import SampleCodeForTest

class SampleCodeForTestUITests: XCTestCase {
    
    func test_loadingState_is_loaded_when_apiData_successfullly_decoded_from_GithubAPI() {
        
        let mockSession = MockApiSession<[Pull], APIError>()
        mockSession.stub.expectedReturnData = getMockJSON()
        let sut = PullsViewModel(apiSession: mockSession)
        sut.loadPulls()
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            if case .loaded(let output) = sut.state {
                if let mockJson = getMockJSON() {
                    let expectedResponse = try! JSONDecoder().decode([Pull].self, from: mockJson)
                    XCTAssertEqual(output.count, expectedResponse.count)
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

extension SampleCodeForTestUITests {
    func getMockJSON() -> Data? {
        if let path = Bundle.main.path(forResource: "SampleResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                return data
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                return nil
            }
        } else {
            print("Invalid filename/path.")
            return nil
        }
    }
}
