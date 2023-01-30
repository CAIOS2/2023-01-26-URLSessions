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
   // let hair: String
    let eyes: String
    let height: Int
    let mass: Int
    let hairs: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        //case hair = "hair_color"
        case eyes = "eye_color"
        case height
        case mass
        case hairs = "hair_color"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        birthYear = try values.decode(String.self, forKey: .birthYear)
       // hair = try values.decode(String.self, forKey: .hair)
        eyes = try values.decode(String.self, forKey: .eyes)
        let heightString = try values.decode(String.self, forKey: .height)
        let massString = try values.decode(String.self, forKey: .mass)
        let hairColor = try values.decode(String.self, forKey: .hairs)
        
        height = Int(heightString) ?? 0
        mass = Int(massString) ?? 0
        hairs = hairColor.split(separator: ",").map { String($0)}
        
        
        
    }
    
}
