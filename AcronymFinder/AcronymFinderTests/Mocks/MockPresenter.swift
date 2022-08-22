//
//  MockPresenter.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockPresenter {
    enum MethodCall: Comparable {
        case userDidSearchText(_ text: String)
    }
}

final class MockPresenter: SearchAcronymsPresentable {
    
    // Input Data
    var searchResults: [SearchResultCellViewModel] = []
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    
    func userDidSearchText(_ text: String) {
        methodsCalled.append(.userDidSearchText(text))
    }
}
