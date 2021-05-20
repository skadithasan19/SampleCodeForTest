import Foundation
import Combine

protocol APISessionProtocol {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
    func requestImage(with builder: RequestBuilder) -> AnyPublisher<Data, APIError>
}
