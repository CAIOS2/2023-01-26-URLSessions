//
//  ViewController.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import UIKit

class ViewController: UIViewController {

    let swapi = StarWarsAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        swapi.fetchFilm(withName: "hope") { result in
            switch result {
            case .success(let films):
                print(films)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

      swapi.fetchPeople(withName: "Leia") { result in
        switch result {
        case .success(let people):
          print(people)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

