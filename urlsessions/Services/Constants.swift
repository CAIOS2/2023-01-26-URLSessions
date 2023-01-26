//
//  Constants.swift
//  urlsessions
//
//  Created by Dmitrij Aneicik on 2023-01-26.
//

import Foundation
enum Constants: String {
    case baseURL = "http://swapi.dev/api/"
    case planetsEndpoint = "planets/"
    case peopleEndpoint = "people/"
    
    static func getURL(for constant: Constants, id: Int) -> URL {
        var urlString = baseURL.rawValue + constant.rawValue + String(id) + "/"
        return URL(string: urlString)!
    }
}

enum APIError: Error {
    case parsingFailed
    case fetchFailed
}
