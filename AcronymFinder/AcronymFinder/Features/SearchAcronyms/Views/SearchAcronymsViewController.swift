//
//  ViewController.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import UIKit

protocol SearchAcronymsViewing: NSObject {
    func showLoadingState()
    func hideLoadingState()
    func reloadData()
}

class SearchAcronymsViewController: UIViewController, SearchAcronymsViewing {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: UIView!
    
    var presenter: SearchAcronymsPresentable!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Search Acronyms"
        view.backgroundColor = UIColor.systemGroupedBackground
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        searchBar.delegate = self
//        loadingView.isHidden = true
        hideLoadingState()
    }
    
    func showLoadingState() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.loadingView.alpha = 1.0
            }
        }
    }
    
    func hideLoadingState() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.loadingView.alpha = 0.0
            }
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.userDidSearchText(searchText)
    }
}
