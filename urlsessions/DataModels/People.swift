//
//  People.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import Foundation

struct People: Codable {
    let name: String
    let birth: String
    let eyes: String
    let hair: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case birth = "birth_year"
        case eyes = "eye_color"
        case hair = "hair_color"
    }
}

