//
//  People.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import Foundation

struct People: Codable {
    let name: String
    let birthYear: String
    let eyes: String
    let hairs: [String]
    let height: Int
    let mass: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case eyes = "eye_color"
        case hairs = "hair_color"
        case height
        case mass
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        birthYear = try values.decode(String.self, forKey: .birthYear)
        eyes = try values.decode(String.self, forKey: .eyes)
        let hair = try values.decode(String.self, forKey: .hairs)
        hairs = hair.split(separator: ",").map { String($0)}
        let _height = try values.decode(String.self, forKey: .height)
        height = Int(_height) ?? 0
        let _mass = try values.decode(String.self, forKey: .mass)
        mass = Int(_mass) ?? 0
    }
}
