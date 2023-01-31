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
    case peopleEndpoint = "people/"
    case filmsEndPoint = "films/"
    
    static func getURL(for constant: Constants, id: Int? = nil) -> URL {
        var baseEndpointURL = baseURL.rawValue + constant.rawValue
        if let id {
            baseEndpointURL = baseEndpointURL + String(id) + "/"
        }
        
        return URL(string: baseEndpointURL)!
    }
}

class StarWarsAPI {
    
    enum APIError: Error {
        case parsingFailed
        case fetchFailed
    }
    
    struct ApiData<T: Decodable>: Decodable {
        let results: [T]
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

    func fetchPeople(completion: @escaping (Result<[People], APIError>) -> Void) {
        performRequest(url: Constants.getURL(for: .peopleEndpoint), callback: { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(ApiData<People>.self, from: data)
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
    func fetchPeople (withName name: String, completion: @escaping (Result<[People], APIError>) -> Void) {
        let peopleUrl = Constants.baseURL.rawValue + Constants.peopleEndpoint.rawValue
        
        var components = URLComponents(string: peopleUrl)
        
        let searchQueryItem = URLQueryItem(name: "search", value: name)
        
        components?.queryItems = [searchQueryItem]
        
        performRequest(url: components?.url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(ApiData<People>.self, from: data)
                    completion(.success(parsedData.results))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchFilm(withName filmName: String, completion: @escaping (Result<[Film], APIError>) -> Void) {
        let filmsUrl = Constants.baseURL.rawValue + Constants.filmsEndPoint.rawValue
        
        var components = URLComponents(string: filmsUrl)
        
        let searchQueryItem = URLQueryItem(name: "search", value: filmName)
        
        components?.queryItems = [searchQueryItem]
        
        performRequest(url: components?.url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let parsedData = try self.decoder.decode(ApiData<Film>.self, from: data)
                    completion(.success(parsedData.results))
                } catch {
                    completion(.failure(.parsingFailed))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
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
