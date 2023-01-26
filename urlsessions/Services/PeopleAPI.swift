//
//  PeopleAPI.swift
//  urlsessions
//
//  Created by Dmitrij Aneicik on 2023-01-26.
//

import Foundation


import Foundation

    


class PeopleAPI {
    
    static func getURL(for constant: Constants, id: Int) -> URL {
        var urlString = Constants.baseURL.rawValue + constant.rawValue + String(id) + "/"
        return URL(string: urlString)!
    }

    
    private let decoder = JSONDecoder()
    private(set) var task: URLSessionDataTask?
    

    
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
