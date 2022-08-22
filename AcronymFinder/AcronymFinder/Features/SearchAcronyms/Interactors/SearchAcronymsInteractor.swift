//
//  SearchAcronymsInteractor.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

protocol SearchAcronymsInteractable {
    func searchForAcronym(_ acronymText: String) async throws -> [Fullform]
}

// Data handling for Search experience
struct SearchAcronymsInteractor: SearchAcronymsInteractable {
    
    let service: SearchServicable
    
    init(service: SearchServicable) {
        self.service = service
    }
    
    func searchForAcronym(_ acronymText: String) async throws -> [Fullform] {
        let response = try await service.searchForAcronym(acronymText)
        return response.fullForms
    }
}
