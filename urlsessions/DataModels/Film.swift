//
//  Film.swift
//  urlsessions
//
//  Created by Romas Petkus on 2023-01-31.
//

import Foundation

struct Film: Codable {
    let title: String
    let episodeId: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
    }
}
