//
//  SearchService.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

protocol SearchServicable {
    func searchForAcronym(_ acronymText: String) async throws -> SearchResponse
}

struct SearchService: SearchServicable {
    
    let httpService: HTTPRequestServiceable
    
    init(httpService: HTTPRequestServiceable = HTTPRequestService()) {
        self.httpService = httpService
    }
    
    func searchForAcronym(_ acronymText: String) async throws -> SearchResponse {
        guard let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py") else {
            throw HTTPError.invalidURL
        }
    
        let response: [SearchResponse] = try await httpService.get(url: url, queryParameters: ["sf": acronymText])
        return response.first ?? SearchResponse(fullForms: [])
    }
}
