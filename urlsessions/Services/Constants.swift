//
//  Constants.swift
//  urlsessions
//
//  Created by Egidijus Vaitkevičius on 2023-01-31.
//

import Foundation

enum Constants: String {
    case baseURL = "http://swapi.dev/api/"
    case planetsEndpoint = "planets/"
    case peopleEndpoint = "people/"

    static func getURL(for constant: Constants, id: Int? = nil) -> URL {
        var baseEndpointURL = baseURL.rawValue + constant.rawValue
        if let id {
            baseEndpointURL = baseEndpointURL + String(id) + "/"
        }
        return URL(string: baseEndpointURL)!
    }
}



