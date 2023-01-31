//
//  Starship.swift
//  urlsessions
//
//  Created by Romas Petkus on 2023-01-31.
//

import Foundation

struct Starship: Decodable {
    let name: String
  let model: String
  let starship_class: String
  let crew: String
//  let films: [Film]





  enum CodingKeys: String, CodingKey {
    case name
    case model
    case starship_class
    case crew = "crew"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    model = try values.decode(String.self, forKey: .model)
    starship_class = try values.decode(String.self, forKey: .starship_class)
    crew = try values.decode(String.self, forKey: .crew)
//    let decodedCrew = try values.decode(String.self, forKey: .crew)
//    crew = Int(decodedCrew) ?? 0


  }
}







