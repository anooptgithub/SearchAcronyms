//
//  SearchServiceTests.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
import XCTest
@testable import AcronymFinder

class HTTPRequestServiceTests: XCTestCase {
    
    var sut: HTTPRequestService!
    var session: MockURLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        session = MockURLSession()
        sut = HTTPRequestService(session: session)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        session = nil
    }

    func testSearchForAcronymWithSuccess() async throws {
        // Given
        let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py")!
        let fileURL = Bundle.main.url(forResource: "SearchMockResponse", withExtension: "txt")
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        session.response = (try Data(contentsOf: fileURL!), response)
        let request = await sut.makeURLRequest(url: url)
        
        // When
        let result: [SearchResponse] = try await sut.get(url: url, queryParameters: ["sf": "SSS"])
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        // Then
        XCTAssertTrue(result.first?.fullForms.count == 2)
        XCTAssertTrue(result.first?.fullForms[0].text == "sick sinus syndrome")
        XCTAssertTrue(session.methodsCalled.containsInOrder([.data(request, nil)]))
    }
    
//    func testSearchForAcronymWithError() async throws {
//        // Given
//        let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py")!
//        let fileURL = Bundle.main.url(forResource: "SearchMockResponse", withExtension: "txt")
//        let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!
//        session.response = (try Data(contentsOf: fileURL!), response)
//        let request = await sut.makeURLRequest(url: url)
//
//        // When
//        let result: [SearchResponse] = try await sut.get(url: url, queryParameters: ["sf": "SSS"])
//
//        let expect = expectation(description: "Wait for Main Thread")
//        asyncAwait(0.1) { expect.fulfill() }
//        wait(for: [expect], timeout: 5.0)
//
//        XCTAssertFalse(true)
//
//    }
}
