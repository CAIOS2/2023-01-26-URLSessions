//
//  People.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import Foundation

struct People: Codable {
    let name: String
    let hairs: [String]
    let mass: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case name
        case hairs = "hair_color"
        case mass
        case height
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let hairsValue = try values.decode(String.self, forKey: .hairs)
        hairs = hairsValue.split(separator: ";").map {String($0) }
        let massValue = try values.decode(String.self, forKey: .mass)
        mass = Int(massValue) ?? 0
        let heightValue = try values.decode(String.self, forKey: .height)
        height = Int(heightValue) ?? 0
        
    }
}
