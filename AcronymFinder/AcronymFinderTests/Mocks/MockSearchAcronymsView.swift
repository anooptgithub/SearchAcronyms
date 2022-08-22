//
//  MockInteractor.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockSearchAcronymsView {
    enum MethodCall: Comparable {
        case setupViewState(_ state: SearchViewState)
        case reloadData
        
        static func < (lhs: MockSearchAcronymsView.MethodCall, rhs: MockSearchAcronymsView.MethodCall) -> Bool {
            switch (lhs, rhs) {
            case (.setupViewState(let lhsState), .setupViewState(let rhsState)):
                return lhsState == rhsState
            case (.reloadData, .reloadData):
                return true
            case (.reloadData, .setupViewState(_)):
                return false
            case (.setupViewState(_), .reloadData):
                return false
            }
        }
    }
}

final class MockSearchAcronymsView: NSObject, SearchAcronymsViewable {
    
    var state: SearchViewState = .beginSearch
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    func setupViewState(_ state: SearchViewState) {
        methodsCalled.append(.setupViewState(state))
        self.state = state
    }
    
    func reloadData() {
        methodsCalled.append(.reloadData)
    }
}
