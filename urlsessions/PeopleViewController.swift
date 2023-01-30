//
//  PeopleViewController.swift
//  urlsessions
//
//  Created by Deividas Zabulis on 2023-01-26.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    let SWAPI = StarWarsAPI()

    private var tableData: [People]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


//        SWAPI.fetchPeople(id: 1) { result in
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//
//                switch result {
//                case .success(let people):
//                    self.peopleNameLabel.text = people.name
//                    print("Label set")
//                case .failure(let error):
//                    self.peopleNameLabel.text = error.localizedDescription
//                    print(error.localizedDescription)
//                }
//            }
//        }

        SWAPI.fetchPeople { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let people):
                    self.tableData = people

                case .failure(let error):
                    // Present error
                    assert(false, "Fetch error!")
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

// MARK: - UITableViewDataSource

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let name = tableData?[indexPath.row].name ?? ""
        let birthYear = tableData?[indexPath.row].birthYear ?? ""
        let hairColor = tableData?[indexPath.row].hairColor ?? ""
        cell.textLabel?.text = "\(name) Year: \(birthYear) Hair color: \(hairColor)"
        return cell
    }
}
