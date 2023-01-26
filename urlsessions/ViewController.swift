//
//  ViewController.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import UIKit

class ViewController: UIViewController {

    struct Film: Codable {
        let title: String
    }

    private var task: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func performFetch(completion: @escaping () -> Void) {

        // #1
        let session = URLSession(configuration: .ephemeral)
        // arba
        //URLSession.shared

        // #2
        let url = URL(string: "http://swapi.dev/api/planets/1/")!
        // arba
//        URLSession.shared.dataTask(with: URL(string: "http://swapi.dev/api/planets/1/")!, completionHandler: T##(Data?, URLResponse?, Error?) -> Void)

        // #3
        task = session.dataTask(with: url) { data, _, error in

            guard let data else { return }

            // # 1 Pavyzdys
            let planet = try? JSONDecoder().decode(Film.self, from: data)
            print(planet?.title ?? "")

            // # 2 Pavyzdys
            let json = try? JSONSerialization.jsonObject(with: data)

            if let dictonary = json as? [String: Any] {

                if let climate = dictonary["climate"] {
                    print(climate)
                    completion()
                }
            }
        }

        task?.resume()

        //arba
        //URLSession.shared.dataTask(with: URL(string: "http://swapi.dev/api/planets/1/")!) { _, _, _ in
        //}.resume()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        task?.cancel()
    }

}

