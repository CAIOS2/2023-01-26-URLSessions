//
//  PlanetsViewController.swift
//  urlsessions
//
//  Created by Tadas Petrikas on 2023-01-25.
//

import UIKit

class PlanetsViewController: UIViewController {

    @IBOutlet private weak var textLabel: UILabel!

    let planetsAPI = PlanetsAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = "Loading..."

        planetsAPI.fetchPlanets { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let planet):
                    self.textLabel.text = planet.name
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
        planetsAPI.task?.cancel()
    }
}
