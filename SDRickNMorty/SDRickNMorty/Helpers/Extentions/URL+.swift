//
//  URL+.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        
        return components?.url
    }
}
