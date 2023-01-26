//
//  PlanetsAPI.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import Foundation

enum Constants: String {
    case baseURL = "http://swapi.dev/api/"
    case planetsEndpoint = "planets/"
    
    static func getURL(for constant: Constants, id: Int) -> URL {
        var urlString = baseURL.rawValue + constant.rawValue + String(id) + "/"
        return URL(string: urlString)!
    }
}

class PlanetsAPI {
    
    enum APIError: Error {
        case parsingFailed
        case fetchFailed
    }
    
    private let decoder = JSONDecoder()
    private(set) var task: URLSessionDataTask?
  
    func fetchPlanets(id: Int, completion: @escaping (Result<Planet, APIError>) -> Void) {
        performRequest(url: Constants.getURL(for: .planetsEndpoint, id: id), callback: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    let planet = try self.decoder.decode(Planet.self, from: data)
                    completion(.success(planet))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
}
                       
                       private func performRequest(url: URL?,  callback: @escaping (Result<Data, APIError>) -> Void) {
            guard let url else { return }
            
            let session = URLSession(configuration: .default)
            task = session.dataTask(with: url) { data, response, error in
                if let data {
                    callback(.success(data))
                } else {
                    callback(.failure(.fetchFailed))
                }
            }
            task?.resume()
        }
                       }
