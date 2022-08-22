//
//  Fullform+Extensions.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest
@testable import AcronymFinder

extension Fullform: Equatable {
    public static func == (lhs: Fullform, rhs: Fullform) -> Bool {
        lhs.text == rhs.text &&
        lhs.since == rhs.since
    }
}
