//
//  StarShipViewController.swift
//  urlsessions
//
//  Created by GK on 2023-01-31.
//

import UIKit

class StarShipViewController: UIViewController {

    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchButtonTapped: UIButton!
    
    let starShipAPI = StarShipAPI()
    var searchFieldValue: String = ""
    
    private var tableData: [StarShip]? {
        didSet {
            tableView.reloadData()
        }
    }
    
 
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        self.fetchStarShip(searchValue: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        starShipAPI.task?.cancel()
    }
  
    private func fetchStarShip(searchValue: String?) {
        
        //TODO: need optimisation
        if  searchValue?.count ?? 0 > 0 {
            starShipAPI.fetchStarShip(name: searchValue ?? "") {result in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let starShip):
                        self.tableData = starShip
                        
                    case .failure(let error):
                        assert(false, "Fetch error!")
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            starShipAPI.fetchStarShip() {result in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let starShip):
                        self.tableData = starShip
                        
                    case .failure(let error):
                        assert(false, "Fetch error!")
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    @IBAction func searchButtonsTapped(_ sender: Any) {
        
        let searchValue = searchField.text
        fetchStarShip(searchValue: searchValue)
        
        
    }
    
    
    
    
    
}

extension StarShipViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starShipCell", for: indexPath)
        guard let starShip = tableData?[indexPath.row] else {return cell}
        
        let name = starShip.name
        let model = starShip.model
        let manufacturer = starShip.manufacturer
        let starShipClass = starShip.starshipClass
        
      //  print("cell :: \(name)")
        
        cell.textLabel?.text = "\(name) (\(model) / \(starShipClass)), \(manufacturer)"
        return cell
    }
}



