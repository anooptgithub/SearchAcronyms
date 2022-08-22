//
//  SearchAcronymsInteractorTests.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest
@testable import AcronymFinder

class SearchAcronymsInteractorTests: XCTestCase {
    
    var sut: SearchAcronymsInteractor!
    var searchService: MockSearchService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        searchService = MockSearchService()
        sut = SearchAcronymsInteractor(service: searchService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        searchService = nil
    }
    
    func testSearchForAcronymWithTextAndSucceeds() async throws {
        // Given
        let fullForms = [
            Fullform(text: "Superior Sagittal Sinus", since: 1976),
            Fullform(text: "Summed Stress Score", since: 1999),
        ]
        searchService.response = SearchResponse(fullForms: fullForms)
        
        // When
        let result = try await sut.searchForAcronym("SSS")
        
        //Then
        XCTAssertTrue(searchService.methodsCalled.containsInOrder([.searchForAcronym("SSS")]))
        XCTAssertTrue(result.count == 2)
        XCTAssertTrue(result == fullForms)
    }
}
