import Foundation

enum APIError: Error {
    case decodingError(String)
    case httpError(Int)
    case authorizationError
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError(let errorName):
            return errorName
        case .httpError(let code):
            if code == 404 {
                return "Not Found"
            } else {
                return "Invalid Input"
            }
        case .authorizationError:
            return "Unknown error"
        case .unknown:
            return "Unknown error"
        }
    }
}
