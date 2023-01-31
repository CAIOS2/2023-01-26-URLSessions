//
//  ViewController.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import UIKit

class ViewController: UIViewController {

    let swapi = StarWarsAPI()
    let starshipAPI = StarshipAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

      
      starshipAPI.fetchStarships(id: 9) { result in
          DispatchQueue.main.async { [weak self] in
              guard let self = self else { return }

              switch result {
              case .success(let people):

                  print(people)
              case .failure(let error):

                  print(error.localizedDescription)
              }
          }
      }


//      starshipAPI.fetchPeople(nameOrModel: "CR90") { result in
//
//        switch result {
//
//
//        case .success(let people):
//
//            print(people)
//        case .failure(let error):
//
//            print(error.localizedDescription)
//        }
//      }

      
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

