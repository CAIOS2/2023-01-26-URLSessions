//
//  StarShipAPI.swift
//  urlsessions
//
//  Created by GK on 2023-01-31.
//

import Foundation

class StarShipAPI {
    
    enum APIError: Error {
        case parsingFailed
        case fetchFailed
    }

    let decoder = JSONDecoder()
    private(set) var task: URLSessionDataTask?
    
    func fetchStarShip( completion: @escaping (Result<[StarShip], APIError>) -> Void) {
       
        
//        let peopleURL = Constants.getURL(for: .peopleEndpoint)
//        var components = URLComponents(string: peopleURL.absoluteString)
//        let searchQuery = URLQueryItem(name: "search", value: name)
//
//        components?.queryItems = [searchQuery]
//
//        let urlString = URL(string: components?.string ?? "")
        
        
      performRequest(url: Constants.getURL(for: .starShipsEnpoint), callback: { [weak self] result in
            guard let self else { return }
            
            struct Data: Decodable {
                let results: [StarShip]
            }
            
            
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(Data.self, from: data)
                   // print("parsed data, url \(Constants.getURL(for: .starShipsEnpoint))")
                    completion(.success(parsedData.results))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
    }
    
    func fetchStarShip(name: String, completion: @escaping (Result<[StarShip], APIError>) -> Void) {
       
        
        let starShipURL = Constants.getURL(for: .starShipsEnpoint)
        var components = URLComponents(string: starShipURL.absoluteString)
        let searchQuery = URLQueryItem(name: "search", value: name)
        components?.queryItems = [searchQuery]
        let urlString = URL(string: components?.string ?? "")
                
      performRequest(url: urlString, callback: { [weak self] result in
            guard let self else { return }
            struct Data: Decodable {
                let results: [StarShip]
            }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(Data.self, from: data)
                 //   print("parsed data, url \(Constants.getURL(for: .starShipsEnpoint))")
                    completion(.success(parsedData.results))
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


