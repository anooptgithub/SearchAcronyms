//
//  MockPresenter.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
@testable import AcronymFinder

extension MockSearchCell {
    enum MethodCall: Comparable {
        case setupData(_ model: SearchResultCellViewModel)
        
        static func == (lhs: MockSearchCell.MethodCall, rhs: MockSearchCell.MethodCall) -> Bool {
            switch (lhs, rhs) {
            case (.setupData(let lhsModel), .setupData(let rhsModel)):
                return lhsModel.titleText == rhsModel.titleText &&
                lhsModel.detailText == rhsModel.detailText
            }
        }
        
        static func < (lhs: MockSearchCell.MethodCall, rhs: MockSearchCell.MethodCall) -> Bool {
            return lhs == rhs
        }
    }
}

final class MockSearchCell: SearchResultCell {
    
    // Verify method calls
    private(set) var methodsCalled = [MethodCall]()
    
    override func setupData(_ model: SearchResultCellViewModel) {
        methodsCalled.append(.setupData(model))
    }
}
