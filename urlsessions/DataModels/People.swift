//
//  People.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import Foundation

struct People: Codable {

  var name: String
  //  let birthYear: String
  //  let eyes: String
  //  let hair: String
  var height: Int
  var mass: Int
  let hairs: [String]

  enum CodingKeys: String, CodingKey {
    case name
    //    case birthYear = "birth_year"
    //    case hair = "hair_color"
    //    case eyes = "eye_color"
    case height = "height"
    case mass = "mass"
    case hairs = "hair_color"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)

   let decodedHeight = try values.decode(String.self, forKey: .height)
    height = Int(decodedHeight) ?? 0

   let decodedMass = try values.decode(String.self, forKey: .mass)
    mass = Int(decodedMass) ?? 0

    let decodedHairs = try values.decode(String.self, forKey: .hairs)
    hairs = decodedHairs.split(separator: ",").map { String($0) }
   


  }

}
