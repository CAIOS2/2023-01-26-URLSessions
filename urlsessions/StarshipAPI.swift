//
//  StarshipAPI.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-31.
//

import Foundation

class StarshipAPI: BaseAPI {
    func fetchStarships(completion: @escaping (Result<[Starship], APIError>) -> Void) {
        performRequest(url: Constants.getURL(for: .starshipsEndPoint)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(ApiData<Starship>.self, from: data)
                    completion(.success(parsedData.results))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }








  func fetchStarships(id: Int, completion: @escaping (Result<Starship, APIError>) -> Void) {
      performRequest(url: Constants.getURL(for: .starshipsEndPoint, id: id), callback: { [weak self] result in
          guard let self else { return }
          switch result {
          case .success(let data):
              do {
                  let starship = try self.decoder.decode(Starship.self, from: data)

                  completion(.success(starship))
              } catch {
                  completion(.failure(.parsingFailed))
              }
          case .failure(let failure):
              completion(.failure(failure))
          }
      })
  }






  func fetchPeople(nameOrModel shipNameOrModel: String, completion: @escaping (Result<[Starship], APIError>) -> Void) {
    let starsShipUrl = Constants.baseURL.rawValue + Constants.starshipsEndPoint.rawValue
    var components = URLComponents(string: starsShipUrl)
    let searchQueryItem = URLQueryItem(name: "search", value: shipNameOrModel)
    components?.queryItems = [searchQueryItem]

    performRequest(url: components?.url) { [weak self] result in
      guard let self else { return }

      switch result {
      case .success(let data):
          do {
              let parsedData = try self.decoder.decode(ApiData<Starship>.self, from: data)
              completion(.success(parsedData.results))
          } catch {
              completion(.failure(.parsingFailed))
          }
      case .failure(let failure):
          completion(.failure(failure))
      }
    }
  }
}
