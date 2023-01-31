//
//  StarshipsAPI.swift
//  urlsessions
//
//  Created by Egidijus Vaitkevičius on 2023-01-31.
//

import Foundation



class Starships: BaseAPI {

  func fetchStarship(completion: @escaping(Starship) -> Void) {

    //creating URL
    guard let url = URL(string: "https://swapi.dev/documentation#starships")
    else { return }

    // creating dataTASK with URLSession and closure
    let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        print("Error fetching movies \(error.localizedDescription)")
      }

      // Data (those bytes we received) needs to be decoded using JSON decoder to data to be fetched.
      // Firstly created DataModel according to data we have, f.e string with exact name as in Data itself
      // created custom model DataModel.
      // now creating json
      guard let jsonData = data else { return }

      let decoder = JSONDecoder()

      do {
        let decodedData = try decoder.decode(Starship.self, from: jsonData)
        completion(decodedData)
      } catch {
        print("Error decoding data")
      }
    }

    dataTask.resume()
  }
}

