//
//  SampleCodeForTestTests.swift
//  SampleCodeForTestTests
//
//  Created by Adit Hasan on 5/20/21.
//

import XCTest

@testable import SampleCodeForTest

class SampleCodeForTestUITests: XCTestCase {
     
    var mockApiSession: MockApiSession<[Pull], APIError>!
    
    override func setUpWithError() throws {
        mockApiSession = MockApiSession<[Pull], APIError>()
        mockApiSession.stub.expectedReturnData = getMockJSON(fileName: "SampleResponse")
    }

    override func tearDownWithError() throws {
        mockApiSession = nil
    }
    
    func test_loadingState_is_loaded_when_apiData_successfullly_decoded_from_GithubAPI() {
         
        let viewModel = PullsViewModel(apiSession: self.mockApiSession)
        viewModel.loadPulls()
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            if case .loaded(let output) = viewModel.state, let firstPull = output.first {
                XCTAssert(firstPull.id == 643814306)
                XCTAssert(firstPull.state == .open)
                XCTAssert(firstPull.node_id == "MDExOlB1bGxSZXF1ZXN0NjQzODE0MzA2")
                XCTAssert(firstPull.title == "title test pr")
                XCTAssert(firstPull.user?.login == "xrinkun")
            } else {
                XCTFail()
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

extension SampleCodeForTestUITests {
    func getMockJSON(fileName:String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
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
