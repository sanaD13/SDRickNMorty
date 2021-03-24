//
//  Paging.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-22.
//

import Foundation

struct Paging<T: Codable>: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case info
        case results
    }
    
    let info: Info
    let results: [T]
}

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
