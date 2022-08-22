//
//  HTTPServices.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

// Concrete implementation of HTTPRequestServiceable

protocol URLSessionable {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionable {}

class HTTPRequestService: HTTPRequestServiceable {

    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    /// Use this for getting data from a GET HTTP endpoint
    func get<ResponseModel: Decodable>(
        url: URL,
        queryParameters: [String: Any]? = [:]
    ) async throws -> ResponseModel {
        
        let urlWithParams = url.encodedWithQueryParameters(queryParameters ?? [:])
        let request = await makeURLRequest(url: urlWithParams)
        async let responseData = data(from: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try await decoder.decode(ResponseModel.self, from: responseData)
    }
}

extension HTTPRequestService {
    func makeURLRequest(url: URL) async -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }

    /// Gets data from API using the URLRequest
    private func data(from urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
       
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LocalizedHTTPRequestError.unexpectedURLResponse
        }

        switch httpResponse.statusCategory {
        // 100 - 199: Informational
        // 200 - 299: Success
        case .informational,
             .success,
             .redirection:
            return data

        // 400 - 499: Client Error
        case .clientError:
            let error = LocalizedHTTPRequestError.clientError(httpResponse.status, data)
            throw error

        // 500 - 599: Server Error
        case .serverError:
            let error = LocalizedHTTPRequestError.serverError(httpResponse.status, data)
            throw error
        }
    }
}
