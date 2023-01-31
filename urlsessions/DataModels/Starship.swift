//
//  Starship.swift
//  urlsessions
//
//  Created by Romas Petkus on 2023-01-31.
//

import Foundation

struct Starship: Decodable {
    let name: String
    let model: String
    let crew: Int
    let starshipClass: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case crew
        case starshipClass = "starship_class"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        model = try values.decode(String.self, forKey: .model)
        let crewValue = try values.decode(String.self, forKey: .crew)
        crew = Int(crewValue) ?? 0
        starshipClass = try values.decode(String.self, forKey: .starshipClass)
    }
    
}
