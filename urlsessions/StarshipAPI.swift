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
    
    func fetchStarships(id: Int, completion: @escaping (Result<[Starship], APIError>) -> Void) {
        
        performRequest(url: Constants.getURL(for: .starshipsEndPoint , id: id)) { [weak self] result in
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
    
    func fetchStarships(withNameOrModel name: String, completion: @escaping (Result<[Starship], APIError>) -> Void) {
        
        let starshipsURL = Constants.getURL(for: .starshipsEndPoint)
        var components = URLComponents(url: starshipsURL, resolvingAgainstBaseURL: false)
        let searchQueryItem = URLQueryItem(name: "search", value: name)
        
        components?.queryItems = [searchQueryItem]
        
        performRequest(url: components?.url) { [weak self] result in
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
}
