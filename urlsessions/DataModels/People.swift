//
//  People.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import Foundation

struct People: Codable {
    let name: String
    let hairColor: String
    let eyesColor: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case hairColor = "hair_color"
        case eyesColor = "eye_color"
    }
}
