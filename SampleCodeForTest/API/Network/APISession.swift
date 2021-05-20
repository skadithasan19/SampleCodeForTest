import Foundation
import Combine

protocol URLSessionProtocol {
    func dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

struct APISession: APISessionProtocol {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
        session.dataTaskPublisher(for: builder.urlRequest)
            .tryMap { result in
                let decoder = JSONDecoder()
                guard let urlResponse = result.response as? HTTPURLResponse else { throw APIError.unknown }
                if !(200...299).contains(urlResponse.statusCode)  {
                    throw APIError.httpError(urlResponse.statusCode)
                } else {
                    return try decoder.decode(T.self, from: result.data)
                }
            }
            .mapError { error in
                print(error)
                switch error {
                case let apiError as APIError:
                    return apiError
                default:
                    return APIError.unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestImage(with builder: RequestBuilder) -> AnyPublisher<Data, APIError> {
        session.dataTaskPublisher(for: builder.urlRequest)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else { throw APIError.unknown }
                if response.statusCode == 200 {
                    return data
                } else {
                    throw APIError.httpError(response.statusCode)
                }
            }
            .mapError { error in
                switch error {
                case let apiError as APIError:
                    return apiError
                default:
                    return APIError.unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

///Wrapper type used by the APISession to Box the given RequestBuilder
struct RefreshBuilder: RequestBuilder {
    var urlRequest: URLRequest
}
