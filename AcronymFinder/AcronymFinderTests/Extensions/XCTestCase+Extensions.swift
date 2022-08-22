//
//  XCTestCase+Extensions.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest

extension XCTestCase {
    func asyncAwait(_ delay: TimeInterval, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
         completion()
        }
    }
}
