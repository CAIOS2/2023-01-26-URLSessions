//
//  PeopleViewController.swift
//  urlsessions
//
//  Created by Dmitrij Aneicik on 2023-01-26.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    let peopleAPI = PeopleAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "Loading..."

        peopleAPI.fetchPeople(id: 1){ result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let people):
                    self.textLabel.text = people.name
                    print("Label set")
                case .failure(let error):
                    self.textLabel.text = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        peopleAPI.task?.cancel()
    }
}

