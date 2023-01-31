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






class StarWarsAPI {
    
    enum APIError: Error {
        case parsingFailed
        case fetchFailed
    }
    
    
    
    let decoder = JSONDecoder()
    private(set) var task: URLSessionDataTask?
    
    
    
    
    // MARK: - Public -
    
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
    
    func fetchPeople(name: String, completion: @escaping (Result<[People], APIError>) -> Void) {
       
        
        let peopleURL = Constants.getURL(for: .peopleEndpoint)
        var components = URLComponents(string: peopleURL.absoluteString)
        let searchQuery = URLQueryItem(name: "search", value: name)
        
        components?.queryItems = [searchQuery]
        
        let urlString = URL(string: components?.string ?? "")
        
        
        performRequest(url: urlString, callback: { [weak self] result in
            guard let self else { return }
            
            struct Data: Decodable {
                let results: [People]
            }
            
            
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(Data.self, from: data)
                    completion(.success(parsedData.results))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
    }
    
    func fetchPeople(id: Int, completion: @escaping (Result<People, APIError>) -> Void) {
        performRequest(url: Constants.getURL(for: .peopleEndpoint, id: id), callback: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                do {
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let people = try self.decoder.decode(People.self, from: data)
                    completion(.success(people))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
    }
    
    // MARK: - Private -
    
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
