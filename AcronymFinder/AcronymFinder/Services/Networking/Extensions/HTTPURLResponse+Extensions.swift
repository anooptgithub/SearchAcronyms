//
//  Data+Extensions.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

extension HTTPURLResponse {

    /// Returns the type safe HTTPStatusCode of the current response
    var status: HTTPStatusCode {
        HTTPStatusCode(rawValue: statusCode) ?? .internalServerError
    }

    /// Returns the HTTPStatusCode.Category for the given response.
    /// **NOTE** If the response code integer is unknown, it will return `500` Server Error.
    var statusCategory: HTTPStatusCode.Category {
        status.responseCategory
    }

    /// Return true if the response code is in the 100 - 199 range.
    var isInformational: Bool {
        status.responseCategory == .informational
    }

    /// Return true if the response code is in the 200 - 299 range.
    var isSuccess: Bool {
        status.responseCategory == .success
    }

    /// Return true if the response code is in the 300 - 399 range.
    var isRedirection: Bool {
        status.responseCategory == .redirection
    }

    /// Return true if the response code is in the 400 - 499 range.
    var isClientError: Bool {
        status.responseCategory == .clientError
    }

    /// Return true if the response code is in the 500 - 599 range.
    var isServerError: Bool {
        status.responseCategory == .serverError
    }
}
