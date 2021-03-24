//
//  LocationController.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import Foundation

class LocationController {
    func fetchMultipleLocations(url: String? = nil, queries: [String: String]? = nil, completion: @escaping (Paging<Location>?) -> Void) {
        
        var validUrl: URL
        let baseURL = URL(string: "https://rickandmortyapi.com/api/location/")!
        
        if let url = url {
            validUrl = URL(string: url)!
        }
        else {
            validUrl = baseURL
        }
        
        if let queries = queries {
            validUrl = validUrl.withQueries(queries)!
        }
        
        let jsonDecoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data, let location = try? jsonDecoder.decode(Paging<Location>.self, from: data) {
                completion(location)
            }
            else {
                print("Not decodable")
                completion(nil)
            }
        }
        task.resume()
    }
}
