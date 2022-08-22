//
//  MockPresenter.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockHTTPService {
    enum MethodCall: Comparable {
        case get(url: URL, queryParameters: [String : Any]?)
        
        static func < (lhs: MockHTTPService.MethodCall, rhs: MockHTTPService.MethodCall) -> Bool {
            lhs == rhs
        }
        
        static func == (lhs: MockHTTPService.MethodCall, rhs: MockHTTPService.MethodCall) -> Bool {
            switch (lhs, rhs) {
            case (.get(let lhsUrl, let lhsQueryParams), .get(let rhsUrl, let rhsQueryParams)):
                return lhsUrl == rhsUrl &&
                lhsQueryParams?.keys == rhsQueryParams?.keys &&
                lhsQueryParams?.values.count == rhsQueryParams?.values.count
            }
        }
    }
}

final class MockHTTPService: HTTPRequestServiceable {
   
    // Input Data
    var response: SearchResponse!
    var error: Error?
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    func get<ResponseObject>(url: URL, queryParameters: [String : Any]?) async throws -> ResponseObject where ResponseObject : Decodable {
        
        methodsCalled.append(.get(url: url, queryParameters: queryParameters))
        
        if let error = error {
            throw error
        } else if let response = [response] as? ResponseObject {
            return response
        } else {
            throw HTTPError.invalidURL
        }
    }
}
