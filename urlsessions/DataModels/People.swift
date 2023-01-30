//
//  People.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import Foundation

struct People: Codable {
  let name: String
  let year: String
  let hair: String

  enum CodingKeys: String, CodingKey {
    case name
    case year = "birthYear"
    case hair = "hairColor"

  }
}
