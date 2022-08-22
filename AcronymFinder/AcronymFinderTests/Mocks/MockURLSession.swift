//
//  MockPresenter.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockURLSession {
    enum MethodCall: Comparable {
        case data(_ request: URLRequest, _ delegate: URLSessionTaskDelegate?)
        
        static func < (lhs: MockURLSession.MethodCall, rhs: MockURLSession.MethodCall) -> Bool {
            lhs == rhs
        }
        
        static func == (lhs: MockURLSession.MethodCall, rhs: MockURLSession.MethodCall) -> Bool {
            switch (lhs, rhs) {
            case (.data(_, _), .data(_, _)):
                return true
            }
        }
    }
}

final class MockURLSession: URLSessionable {
    
    // Input Data
    var response: (Data, URLResponse)!
    var error: Error?
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        methodsCalled.append(.data(request, delegate))
        
        if let error = error {
            throw error
        } else if let response = response {
            return response
        } else {
            throw HTTPError.invalidURL
        }
    }
}
