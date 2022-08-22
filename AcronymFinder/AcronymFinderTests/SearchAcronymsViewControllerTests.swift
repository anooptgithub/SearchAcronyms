//
//  SearchAcronymsViewControllerTests.swift
//  AcronymFinderTests
//
//  Created by Anoop Thomas on 8/21/22.
//

import XCTest
@testable import AcronymFinder

class SearchAcronymsViewControllerTests: XCTestCase {
    
    var sut: SearchAcronymsViewController!
    var presenter: MockPresenter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = MockPresenter()
        sut = SearchAcronymsViewController.defaultInstance()
        sut.presenter = presenter
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        presenter = nil
    }
    
    func testViewDidLoadToEnsureViewISSetupCorrectly() throws {
        // Given
        let fullForms = [
            Fullform(text: "Superior Sagittal Sinus", since: 1976),
            Fullform(text: "Summed Stress Score", since: 1999),
        ]
        presenter.searchResults = fullForms.map {
            SearchResultCellViewModel(titleText: $0.text.capitalized, detailText: "Coined in \($0.since)")
        }
        
        // When
        sut.viewDidLoad()
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        //Then
        XCTAssertTrue(sut.tableView.dataSource === sut)
        XCTAssertTrue(sut.container.subviews.contains(sut.beginSearchView))
        XCTAssertTrue(sut.container.subviews.contains(sut.loadingStateView))
        XCTAssertTrue(sut.container.subviews.contains(sut.noResultsView))
        XCTAssertTrue(sut.beginSearchView.isHidden == false)
        XCTAssertTrue(sut.noResultsView.isHidden == true)
        XCTAssertTrue(sut.loadingStateView.isHidden == true)
        XCTAssertTrue(sut.container.alpha == 1.0)
    }
    
    func testSetupStateToBeginSearch() throws {
        // Given
        
        // When
        sut.viewDidLoad()
        sut.setupViewState(.beginSearch)
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        //Then
        XCTAssertTrue(sut.beginSearchView.isHidden == false)
        XCTAssertTrue(sut.noResultsView.isHidden == true)
        XCTAssertTrue(sut.loadingStateView.isHidden == true)
        XCTAssertTrue(sut.container.alpha == 1.0)
    }
    
    func testSetupStateToNoResults() throws {
        // Given
        
        // When
        sut.viewDidLoad()
        sut.setupViewState(.noResults)
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        //Then
        XCTAssertTrue(sut.beginSearchView.isHidden == true)
        XCTAssertTrue(sut.noResultsView.isHidden == false)
        XCTAssertTrue(sut.loadingStateView.isHidden == true)
        XCTAssertTrue(sut.container.alpha == 1.0)
    }
    
    func testSetupStateToSearchInProgress() throws {
        // Given
        
        // When
        sut.viewDidLoad()
        sut.setupViewState(.searchInProgress)
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        //Then
        XCTAssertTrue(sut.beginSearchView.isHidden == true)
        XCTAssertTrue(sut.noResultsView.isHidden == true)
        XCTAssertTrue(sut.loadingStateView.isHidden == false)
        XCTAssertTrue(sut.container.alpha == 1.0)
    }
    
    func testSetupStateToShowResults() throws {
        // Given
        
        // When
        sut.viewDidLoad()
        sut.setupViewState(.showResults)
        
        let expect = expectation(description: "Wait for Main Thread")
        asyncAwait(0.1) { expect.fulfill() }
        wait(for: [expect], timeout: 5.0)
        
        //Then
        XCTAssertTrue(sut.container.alpha == 0.0)
    }
    
    func testSearchBarDidChangeText() throws {
        // Given
        
        // When
        sut.viewDidLoad()
        sut.searchBar(UISearchBar(), textDidChange: "SSS")
        
        //Then
        XCTAssertTrue(presenter.methodsCalled.containsInOrder([.userDidSearchText("SSS")]))
    }
}
