//
//  Film.swift
//  urlsessions
//
//  Created by nonamekk on 2023-01-30.
//

import Foundation
struct Film: Codable {
    let title: String
    let producers: [String]
    let episodeNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case producers = "producer"
        case episodeNumber = "episodeId"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        episodeNumber = try values.decode(Int.self, forKey: .episodeNumber)
        let producer = try values.decode(String.self, forKey: .producers)
        
//        producers = producerString.split(separator: ",").map { String($0) }
        producers = producer.components(separatedBy: ", ")
    }
}
