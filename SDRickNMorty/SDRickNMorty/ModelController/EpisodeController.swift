//
//  EpisodeController.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import Foundation

class EpisodeController {
    func fetchMultipleEpisodes(url: String? = nil, queries: [String: String]? = nil, completion: @escaping (Paging<Episode>?) -> Void) {
        
        var validUrl: URL
        let baseURL = URL(string: "https://rickandmortyapi.com/api/episode/")!
        
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
            if let data = data, let episode = try? jsonDecoder.decode(Paging<Episode>.self, from: data) {
                completion(episode)
            }
            else {
                print("Not decodable")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchCharacterEpisodes(idList: [String], queries: [String: String]? = nil, completion: @escaping ([Episode]?) -> Void) {
        var baseURL = URL(string: "https://rickandmortyapi.com/api/episode/")!
        baseURL.appendPathComponent(idList.joined(separator: ","))
        
        if let queries = queries {
            baseURL = baseURL.withQueries(queries)!
        }
        let jsonDecoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data, let episodes = try? jsonDecoder.decode([Episode].self, from: data) {
                
                completion(episodes)
            }
            else if let data = data, let episode = try?
                        jsonDecoder.decode(Episode.self, from: data) {
                
                completion([episode])
            }
            else {
                print("Not decodable")
                completion(nil)
            }
        }
        task.resume()
    }
}
