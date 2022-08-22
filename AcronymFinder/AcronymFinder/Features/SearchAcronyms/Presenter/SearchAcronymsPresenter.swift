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
    weak var view: SearchAcronymsViewing!
    private(set) var searchResults: [SearchResultCellViewModel] = []
    
    init(
        view: SearchAcronymsViewing,
        interactor: SearchAcronymsInteractable,
        throller: SearchThrottlable
    ) {
        self.view = view
        self.interactor = interactor
        self.throller = throller
    }
    
    func userDidSearchText(_ text: String) {
        // Throttles searching when user is typing fast
        // to avoid unecessary API calls
        throller.searchTextChanged(text) { [weak self] in
            self?.searchAndUpdateUI(text)
        }
    }
}

private extension SearchAcronymsPresenter {
    func searchAndUpdateUI(_ acronymText: String) {
        view.showLoadingState()
        Task {
            do {
                let result  = try await interactor.searchForAcronym(acronymText)
                searchResults = result.map {
                    SearchResultCellViewModel(titleText: $0.text.capitalized, detailText: "Since \($0.since)")
                }
                view.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            
            view.hideLoadingState()
        }
    }
}
