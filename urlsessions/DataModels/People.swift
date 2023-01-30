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
  let hair: String
//  let created: Date

  enum CodingKeys: String, CodingKey {
    case name
    case birthYear
    case hair = "hairColor"
    case eyes = "eyeColor"
  }

}
