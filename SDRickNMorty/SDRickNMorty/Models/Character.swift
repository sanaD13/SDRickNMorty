//
//  Character.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-22.
//

import Foundation

struct Character: Codable, Equatable {
    var id: Int
    var name: String
    var species: String
    var gender: String
    var status: String
    var origin: [String: String]
    var location: [String: String]
    var image: String
    var episodes: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species = "species"
        case gender
        case status
        case origin
        case location
        case image
        case episodes = "episode"
        case url
        case created
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        species = try container.decode(String.self, forKey: .species)
        gender = try container.decode(String.self, forKey: .gender)
        status = try container.decode(String.self, forKey: .status)
        origin = try container.decode([String: String].self, forKey: .origin)
        location = try container.decode([String: String].self, forKey: .location)
        image = try container.decode(String.self, forKey: .image)
        episodes = try container.decode([String].self, forKey: .episodes)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(String.self, forKey: .created)
    }
}
