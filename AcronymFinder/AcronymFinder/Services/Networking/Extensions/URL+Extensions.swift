//
//  Data+Extensions.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import Foundation

extension URL {

    /// Encodes a dictionary to query parameters.
    /// - Parameter parameters: [String: Any]
    /// - Returns: URL with the encoded parameters
    func encodedWithQueryParameters(_ parameters: [String: Any]) -> URL {
        guard parameters.isEmpty == false else { return self }
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        let currentParameters = components?.percentEncodedQuery ?? ""
        let mergedParameters = currentParameters + makeEncodedStringForParameters(parameters)
        components?.percentEncodedQuery = mergedParameters
        return components?.url ?? self
    }
}

private extension URL {
    /// Converts the doctionary of parameters to a URL encoded string representation.
    func makeEncodedStringForParameters(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components.append((urlEncode(key), urlEncode("\(value)")))
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    func urlEncode(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}
