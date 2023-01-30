//
//  PeoplePlus.swift
//  urlsessions
//
//  Created by nonamekk on 2023-01-27.
//

import Foundation

struct PeoplePlus: Decodable {
    let name: String
    let hair: String
    let eyes: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case eyes = "eyeColor"
        case hair = "hairColor"
    }
}
