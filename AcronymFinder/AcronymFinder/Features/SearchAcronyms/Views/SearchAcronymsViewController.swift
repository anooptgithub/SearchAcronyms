//
//  ViewController.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import UIKit
import SwiftUI

enum SearchViewState {
    case beginSearch
    case noResults
    case searchInProgress
    case showResults
}

protocol SearchAcronymsViewable: NSObject {
    func setupViewState(_ state: SearchViewState)
    func reloadData()
}

class SearchAcronymsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var container: UIView!
    
    var presenter: SearchAcronymsPresentable!
    lazy var noResultsView: UIView = {
        let vc = UIHostingController(rootView: EmptyStateView(state: .noResultsFound))
        addChild(vc)
        return vc.view
    }()
    
    lazy var beginSearchView: UIView = {
        let vc = UIHostingController(rootView: EmptyStateView(state: .beginSearch))
        addChild(vc)
        return vc.view
    }()
    
    lazy var loadingStateView: UIView = {
        let vc = UIHostingController(rootView: LoadingView())
        addChild(vc)
        return vc.view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupInitialState() {
        title = "Search Acronyms"
        view.backgroundColor = UIColor.systemGroupedBackground
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        searchBar.delegate = self
        
        container.addSubview(noResultsView)
        container.addSubview(beginSearchView)
        container.addSubview(loadingStateView)
        noResultsView.fillSuperView()
        beginSearchView.fillSuperView()
        loadingStateView.fillSuperView()
        setupViewState(.beginSearch)
    }
}

// MARK: - SearchAcronymsViewable protocol conformance

extension SearchAcronymsViewController: SearchAcronymsViewable {
    func setupViewState(_ state: SearchViewState) {
        DispatchQueue.main.async {
            switch state {
            case .beginSearch:
                self.beginSearchView.isHidden = false
                self.noResultsView.isHidden = true
                self.loadingStateView.isHidden = true
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.container.alpha = 1.0
                }
            case .noResults:
                self.beginSearchView.isHidden = true
                self.noResultsView.isHidden = false
                self.loadingStateView.isHidden = true
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.container.alpha = 1.0
                }
            case .searchInProgress:
                self.beginSearchView.isHidden = true
                self.noResultsView.isHidden = true
                self.loadingStateView.isHidden = false
                UIView.animate(withDuration: 0.3, delay: 0) {
                    self.container.alpha = 1.0
                }
            case .showResults:
                self.container.alpha = 0.0
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchAcronymsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell
        else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.setupData(presenter.searchResults[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchAcronymsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.userDidSearchText(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
