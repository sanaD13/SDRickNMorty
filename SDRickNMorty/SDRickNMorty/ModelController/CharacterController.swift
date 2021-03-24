//
//  CharacterController.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import Foundation

class CharacterController {
    func fetchMultipleCharacters(url: String? = nil, queries: [String: String]? = nil, completion: @escaping (Paging<Character>?) -> Void) {
        
        var validUrl: URL
        let baseURL = URL(string: "https://rickandmortyapi.com/api/character/")!
        
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
        
        let task = URLSession.shared.dataTask(with: validUrl) { (data, response, error) in
            if let safeData = data, let pagedData = try? jsonDecoder.decode(Paging<Character>.self, from: safeData) {
                completion(pagedData)
            }
            else {
                print("Not decodable")
                completion(nil)
            }
        }
        task.resume()
    }
}
