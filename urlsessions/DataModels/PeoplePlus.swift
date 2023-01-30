//
//  PeoplePlus.swift
//  urlsessions
//
//  Created by nonamekk on 2023-01-27.
//

import Foundation

struct PeoplePlus: Decodable {
    let name: String
    let hairs: [String]
    let eyes: String
    let mass: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case eyes = "eyeColor"
        case hairs = "hairColor"
        case mass
        case height
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mass = try values.decode(Int.self, forKey: .mass)
        height = try values.decode(Int.self, forKey: .height)
        
        let hair = try values.decode(String.self, forKey: .hairs)
        
        hairs = hair.components(separatedBy: ", ")
        name = try values.decode(String.self, forKey: .name)
        eyes = try values.decode(String.self, forKey: .eyes)
    }
}
