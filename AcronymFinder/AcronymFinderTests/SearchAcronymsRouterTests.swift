//
//  SearchAcronymsRouterTests.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest
@testable import AcronymFinder

class SearchAcronymsRouterTests: XCTestCase {
    
    var sut: SearchAcronymsRouter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchAcronymsRouter()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func testCreationOfViewControllerSucceeds() async throws {
        // Given
        
        // When
        guard let vc = sut.createSearchViewController() as? SearchAcronymsViewController else {
            throw NSError()
        }
        
        //Then
        guard let presenter = await vc.presenter as? SearchAcronymsPresenter else {
            throw NSError()
        }
        
        XCTAssertNotNil(presenter.interactor as? SearchAcronymsInteractor)
        XCTAssertNotNil(presenter.throller as? SearchThrottler)
    }
}
