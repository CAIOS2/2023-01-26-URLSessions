//
//  FilmProducersViewController.swift
//  urlsessions
//
//  Created by nonamekk on 2023-01-30.
//

import UIKit

class FilmProducersViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    let SWAPI = StarWarsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Loading..."
        
        SWAPI.fetchFilmProducers(id: 1) { result in
            DispatchQueue.main.async { [weak self] in 
                guard let self = self else { return }
                
                switch result {
                case .success(let film):
                    var textToShow = ""
                    for each in film.producers {
                        textToShow = each + "\n"
                    }
                    
                    self.label.text = textToShow
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
