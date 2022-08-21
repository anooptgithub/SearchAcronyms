//
//  HTTPServices.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
}

enum LocalizedHTTPRequestError {
    case redirection(HTTPStatusCode, Data?)
    case clientError(HTTPStatusCode, Data?)
    case serverError(HTTPStatusCode, Data?)
    case unexpectedURLResponse

    init(statusCode: HTTPStatusCode) {
        switch statusCode.responseCategory {
        case .redirection:
            self = .redirection(statusCode, nil)
        case .clientError:
            self = .clientError(statusCode, nil)
        case .serverError:
            self = .serverError(statusCode, nil)
        default:
            self = .unexpectedURLResponse
        }
    }
}

extension LocalizedHTTPRequestError: Error {
    var localizedDescription: String {
        "Network Error"
    }
}

extension LocalizedHTTPRequestError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .redirection:
            return "HTTP Redirect"
        case .clientError:
            return "Client Error"
        case .serverError:
            return "Server Error"
        case .unexpectedURLResponse:
            return "Unknown Error"
        }
    }

    var recoverySuggestion: String? {
        "Please try again."
    }

    var failureReason: String? {
        switch self {
        case .redirection(let code, _),
             .clientError(let code, _),
             .serverError(let code, _):
            return "Error Code: \(code.intValue) \(code.prettyString)"
        case .unexpectedURLResponse:
            return nil
        }
    }
}
