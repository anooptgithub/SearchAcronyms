//
//  MockSearchThrottler.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockSearchThrottler {
    enum MethodCall: Comparable {
        case searchTextChanged(_ text: String)
    }
}

final class MockSearchThrottler: SearchThrottlable {

    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    func searchTextChanged(_ text: String?, completion: @escaping () -> Void) {
        methodsCalled.append(.searchTextChanged(text ?? "unkown"))
        completion()
    }
}
