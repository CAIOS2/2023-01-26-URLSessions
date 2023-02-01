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
      starshipApi.fetchStarships(id: 9){ result in
        switch result {
        case .success(let startshipID):
          print(startshipID)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }

      starshipApi.fetchStarships(withName: "Star Destroyer") { result in
        switch result {
        case .success(let startshipName):
          print(startshipName)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }

      starshipApi.fetchStarships(withModel: "DS-1") { result in
        switch result {
        case .success(let starshipModel):
          print(starshipModel)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

