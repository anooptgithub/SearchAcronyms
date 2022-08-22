//
//  AcronymFinderTests.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest
@testable import AcronymFinder

class SearchAcronymsPresenterTests: XCTestCase {
    
    var sut: SearchAcronymsPresenter!
    var view: MockSearchAcronymsView!
    var interactor: MockInteractor!
    var throller: MockSearchThrottler!

    override func setUpWithError() throws {
        try super.setUpWithError()
        view = MockSearchAcronymsView()
        interactor = MockInteractor()
        throller = MockSearchThrottler()
        sut = SearchAcronymsPresenter(
            view: view,
            interactor: interactor,
            throller: throller
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        view = nil
        interactor = nil
        throller = nil
    }

    func testUserDidSearchWithATextAndShowResults() throws {
        // Given
        interactor.fullForms = [
            Fullform(text: "Superior Sagittal Sinus", since: 1976),
            Fullform(text: "Summed Stress Score", since: 1999),
        ]
        
        // When
        sut.userDidSearchText("SSS")
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        // Then
        XCTAssertTrue(throller.methodsCalled.containsInOrder([.searchTextChanged("SSS")]))
        XCTAssertTrue(view.methodsCalled.containsInOrder([.setupViewState(.searchInProgress), .reloadData, .setupViewState(.showResults)]))
        XCTAssertTrue(sut.searchResults.count == 2)
        XCTAssertTrue(sut.searchResults[0].titleText.capitalized == interactor.fullForms[0].text.capitalized)
        XCTAssertTrue(sut.searchResults[1].titleText.capitalized == interactor.fullForms[1].text.capitalized)
        XCTAssertTrue(sut.searchResults[0].detailText == "Coined in \(interactor.fullForms[0].since)")
        XCTAssertTrue(sut.searchResults[1].detailText == "Coined in \(interactor.fullForms[1].since)")
        XCTAssertTrue(interactor.methodsCalled.containsInOrder([.searchForAcronym("SSS")]))
    }
    
    func testUserDidSearchWithEmptyTextAndInteractorIsNotCalled() throws {
        // Given
        interactor.fullForms = [
            Fullform(text: "Superior Sagittal Sinus", since: 1976),
            Fullform(text: "Summed Stress Score", since: 1999),
        ]
        
        // When
        sut.userDidSearchText("")
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        // Then
        XCTAssertTrue(throller.methodsCalled.containsInOrder([.searchTextChanged("")]))
        XCTAssertTrue(view.methodsCalled.containsInOrder([.setupViewState(.beginSearch)]))
        XCTAssertTrue(view.methodsCalled.doesNotContainAny([.setupViewState(.showResults), .reloadData]))
        XCTAssertTrue(sut.searchResults.count == 0)
        XCTAssertFalse(interactor.methodsCalled.containsInOrder([.searchForAcronym("")]))
    }
    
    func testUserDidSearchWithATextButInteractorReturnsZeroDataAndNoResultIsShown() throws {
        // Given
        interactor.fullForms = []
        
        // When
        sut.userDidSearchText("SSS")
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        // Then
        XCTAssertTrue(throller.methodsCalled.containsInOrder([.searchTextChanged("SSS")]))
        XCTAssertTrue(view.methodsCalled.containsInOrder(
            [.setupViewState(.searchInProgress), .setupViewState(.noResults)]))
        XCTAssertTrue(sut.searchResults.count == 0)
        XCTAssertTrue(interactor.methodsCalled.containsInOrder([.searchForAcronym("SSS")]))
    }
    
    func testUserDidSearchWithATextButInteractorReturnsError() throws {
        // Given
        interactor.fullForms = []
        interactor.error = HTTPError.invalidURL
        
        // When
        sut.userDidSearchText("SSS")
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        // Then
        XCTAssertTrue(throller.methodsCalled.containsInOrder([.searchTextChanged("SSS")]))
        XCTAssertTrue(view.methodsCalled.containsInOrder(
            [.setupViewState(.searchInProgress), .setupViewState(.noResults)]))
        XCTAssertTrue(view.methodsCalled.doesNotContainAny([.setupViewState(.showResults), .reloadData]))
        XCTAssertTrue(sut.searchResults.count == 0)
        XCTAssertTrue(interactor.methodsCalled.containsInOrder([.searchForAcronym("SSS")]))
    }
}
