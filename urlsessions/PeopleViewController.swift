//
//  PeopleViewController.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import UIKit

class PeopleViewController: UIViewController {
    
    
    @IBOutlet weak var peopleNameLabel: UILabel!
    
    let SWAPI = StarWarsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        peopleNameLabel.text = "Loading..."

        SWAPI.fetchPeople (id: 1){ result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let people):
                    self.peopleNameLabel.text = people.name
                    print("Label set")
                case .failure(let error):
                    self.peopleNameLabel.text = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SWAPI.task?.cancel()
    }
}
