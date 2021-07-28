//
//  MockApiSession.swift
//  SampleCodeForTestUITests
//
//  Created by Adit Hasan on 5/20/21.
//

import Combine
import Foundation
@testable import SampleCodeForTest

struct MockApiSession<Output: Decodable, Failure: Error>: APISessionProtocol {

    class Stub {
        var expectedResult: Result<Output?, APIError> = .success(nil)
        var expectedReturnData: Data!
    }

    var stub = Stub()

    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T : Decodable {
        if case .success = stub.expectedResult {
            let result = try! JSONDecoder().decode(Output.self, from: stub.expectedReturnData)
            return Result.Publisher(result as! T).eraseToAnyPublisher()
        } else if case .failure(let error) = stub.expectedResult {
            return Result.Publisher(error).eraseToAnyPublisher()
        } else {
            fatalError("Bad test data")
        }
    }

    func requestImage(with builder: RequestBuilder) -> AnyPublisher<Data, APIError> {
        Result.Publisher(.failure(APIError.unknown)).eraseToAnyPublisher()
    }
}
