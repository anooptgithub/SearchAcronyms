//
//  SearchResponse.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

struct SearchResponse: Codable {
    let fullForms: [Fullform]
    
    enum CodingKeys: String, CodingKey {
        case fullForms = "lfs"
    }
}

struct Fullform: Codable {
    let text: String
    let since: Int
    
    enum CodingKeys: String, CodingKey {
        case text = "lf"
        case since
    }
}
