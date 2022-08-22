//
//  MockInteractor.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockInteractor {
    enum MethodCall: Comparable {
        case searchForAcronym(_ acronymText: String)
    }
}

final class MockInteractor: SearchAcronymsInteractable {
    
    // Input Data
    var fullForms: [Fullform] = []
    var error: Error?
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    func searchForAcronym(_ acronymText: String) async throws -> [Fullform] {
        methodsCalled.append(.searchForAcronym(acronymText))
        
        if let error = error {
            throw error
        } else {
            return fullForms
        }
    }
}
