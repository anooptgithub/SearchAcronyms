//
//  SearchServiceTests.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest
@testable import AcronymFinder

class SearchServiceTests: XCTestCase {
    
    var sut: SearchService!
    var httpService: MockHTTPService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        httpService = MockHTTPService()
        sut = SearchService(httpService: httpService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        httpService = nil
    }

    func testSearchForAcronymWithSuccess() async throws {
        // Given
        let fullForms = [
            Fullform(text: "Superior Sagittal Sinus", since: 1976),
            Fullform(text: "Summed Stress Score", since: 1999),
        ]
        httpService.response = SearchResponse(fullForms: fullForms)
        let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py")!
        
        // When
        let result = try await sut.searchForAcronym("SSS")
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        // Then
        XCTAssertTrue(result.fullForms.count == 2)
        XCTAssertTrue(result.fullForms == fullForms)
        XCTAssertTrue(httpService.methodsCalled.containsInOrder([.get(url: url, queryParameters: ["sf": "SSS"])]))
    }
}
