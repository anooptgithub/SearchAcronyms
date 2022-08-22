//
//  MockInteractor.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockSearchService {
    enum MethodCall: Comparable {
        case searchForAcronym(_ acronymText: String)
    }
}

final class MockSearchService: NSObject, SearchServicable {
    var response: SearchResponse?
    var error: Error?
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
  
    func searchForAcronym(_ acronymText: String) async throws -> SearchResponse {
        methodsCalled.append(.searchForAcronym(acronymText))
        if let error = error {
            throw error
        } else if let response = response {
            return response
        } else {
            throw HTTPError.invalidURL
        }
    }
}
