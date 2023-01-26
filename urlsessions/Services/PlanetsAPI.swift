//
//  PlanetsAPI.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import Foundation

class Parameters {
    var requestIndex: Int = 1
}

//negrazu, ne puiku
var index = Parameters().requestIndex


enum Constants: String {
    case baseURL = "http://swapi.dev/api/"
    case planetsEndpoint = "planets/"

    static func getURL(for constant: Constants) -> URL {
       // var requestIndex: Int = 2
        var urlString = baseURL.rawValue + constant.rawValue + String(index)
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
    
    
   // var url = Constants.getURL(for: .planetsEndpoint) + "\(requestIndex)"
    
    func fetchPlanets(completion: @escaping (Result<Planet, APIError>) -> Void) {
        performRequest(url: Constants.getURL(for: .planetsEndpoint)) { [weak self] result in
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
        }
        index += 1
        
    }

    private func performRequest(url: URL?, callback: @escaping (Result<Data, APIError>) -> Void) {
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
