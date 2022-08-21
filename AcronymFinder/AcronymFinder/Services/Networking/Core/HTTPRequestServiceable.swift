//
//  HTTPServices.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation
import SwiftUI

protocol HTTPRequestServiceable {
    func get<ResponseObject: Decodable>(
        url: URL,
        queryParameters: [String: Any]?
    ) async throws -> ResponseObject
}
