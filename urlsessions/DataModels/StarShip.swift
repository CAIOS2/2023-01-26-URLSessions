//
//  StarShip.swift
//  urlsessions
//
//  Created by GK on 2023-01-31.
//

import Foundation


import Foundation

struct StarShip: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let starshipClass: String
//    let mass: Int
//    let hairs: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case starshipClass = "starship_class"
//        case mass
//        case hairs = "hair_color"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        model = try values.decode(String.self, forKey: .model)
        manufacturer = try values.decode(String.self, forKey: .manufacturer)
        starshipClass = try values.decode(String.self, forKey: .starshipClass)
        
        
//        let heightString = try values.decode(String.self, forKey: .height)
//        let massString = try values.decode(String.self, forKey: .mass)
//        let hairColor = try values.decode(String.self, forKey: .hairs)
//        height = Int(heightString) ?? 0
//        mass = Int(massString) ?? 0
//        hairs = hairColor.split(separator: ",").map { String($0)}
    }
}
