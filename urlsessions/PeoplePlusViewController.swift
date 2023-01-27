//
//  PeoplePlusViewController.swift
//  urlsessions
//
//  Created by nonamekk on 2023-01-27.
//

import UIKit

class PeoplePlusViewController: UIViewController {
    
    let SWAPI = StarWarsAPI()
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Loading..."
        
        SWAPI.fetchPersonDetails(id: 2) { result in DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            switch result {
            case .success(let person):
                self.label.text = "Name: " + person.name + "\n" + "Hair color: " + person.hairColor + "\n" + "Skin color: " + person.skinColor
            case .failure(let error):
                self.label.text = error.localizedDescription
            }
        }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SWAPI.task?.cancel()
    }
}
