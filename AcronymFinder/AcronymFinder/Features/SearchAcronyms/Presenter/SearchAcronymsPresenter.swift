//
//  SearchAcronymsPresenter.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

protocol SearchAcronymsPresentable {
    var searchResults: [SearchResultCellViewModel] { get }
    
    func userDidSearchText(_ text: String)
}

final class SearchAcronymsPresenter: SearchAcronymsPresentable {
    
    let interactor: SearchAcronymsInteractable
    let throller: SearchThrottlable
    weak var view: SearchAcronymsViewable!
    private(set) var searchResults: [SearchResultCellViewModel] = []
    
    init(
        view: SearchAcronymsViewable,
        interactor: SearchAcronymsInteractable,
        throller: SearchThrottlable
    ) {
        self.view = view
        self.interactor = interactor
        self.throller = throller
    }
    
    func userDidSearchText(_ text: String) {
        view.setupViewState(text.isEmpty ? .beginSearch : .searchInProgress)
        
        // Throttles searching when user is typing fast to avoid unecessary API calls
        throller.searchTextChanged(text) { [weak self] in
            guard text.isEmpty == false else { return }
            self?.searchAndUpdateUI(text)
        }
    }
}

private extension SearchAcronymsPresenter {
    
    /// Searches and loads the results to UI
    func searchAndUpdateUI(_ acronymText: String) {
        view.setupViewState(.searchInProgress)
        Task {
            do {
                let result  = try await interactor.searchForAcronym(acronymText)
                searchResults = result.map {
                    SearchResultCellViewModel(titleText: $0.text.capitalized, detailText: "Coined in \($0.since)")
                }
                view.reloadData()
                view.setupViewState(searchResults.count > 0 ? .showResults : .noResults)
            } catch {
                print(error.localizedDescription)
                view.setupViewState(.noResults)
            }
        }
    }
}
