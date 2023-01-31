//
//  BaseAPI.swift
//  urlsessions
//
//  Created by Egidijus Vaitkevičius on 2023-01-31.
//

import Foundation

class BaseAPI {


  enum APIError: Error {
      case parsingFailed
      case fetchFailed
  }


  let decoder = JSONDecoder()
  private(set) var task: URLSessionDataTask?




  // MARK: - Public -
init() {

//    decoder.keyDecodingStrategy = .convertFromSnakeCase
}

  func performRequest(url: URL?,  callback: @escaping (Result<Data, APIError>) -> Void) {
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

