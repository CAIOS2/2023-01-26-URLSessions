//
//  PeopleViewController.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import UIKit

class PeopleViewController: UIViewController {
    
    
    @IBOutlet weak var peopleLabel: UILabel!
    
    let planetsAPI = PlanetsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        peopleLabel.text = "Loading..."

        planetsAPI.fetchPeople (id: 1){ result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let people):
                    self.peopleLabel.text = people.name
                    print("Label set")
                case .failure(let error):
                    self.peopleLabel.text = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        planetsAPI.task?.cancel()
    }
}
