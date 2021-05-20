import Combine

protocol Loadable: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
}

enum LoadingState<Output> {
    case idle
    case failed(APIError)
    case loaded(Output)
    case loading
}
