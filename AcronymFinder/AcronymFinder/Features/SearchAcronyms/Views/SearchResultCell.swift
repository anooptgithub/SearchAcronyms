//
//  SearchResultCell.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.font = .preferredFont(forTextStyle: .headline)
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.accessibilityIdentifier = "acronym-full-form"
        detailTextLabel?.accessibilityIdentifier = "acronym-since-date"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
    
    func setupData(_ model: SearchResultCellViewModel) {
        textLabel?.text = model.titleText
        detailTextLabel?.text = model.detailText
    }
}
