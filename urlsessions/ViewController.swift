//
//  ViewController.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import UIKit

class ViewController: UIViewController {

    let swapi = StarWarsAPI()
    let starshipApi = StarshipAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        starshipApi.fetchStarships { result in
            switch result {
            case .success(let starships):
                print(starships)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        starshipApi.fetchStarships(id: 3) { result in
            switch result {
            case .success(let starships):
                print(starships)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        starshipApi.fetchStarships(withQuery: "Naboo") { result in
            switch result {
            case .success(let starships):
                print(starships)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

