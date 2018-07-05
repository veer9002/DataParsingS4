//
//  DataVC.swift
//  DataParsingS4
//
//  Created by Syon on 17/05/18.
//  Copyright © 2018 Syon. All rights reserved.
//

import UIKit

struct Places: Decodable {
    let results: [PlacesInfo]
}

struct PlacesInfo: Decodable {
    let name: String
    let vicinity: String
}

class DataVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var placesArray = [PlacesInfo]()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        queryGooglePlaces()
    }
    
    func queryGooglePlaces() {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=22.274257,73.188440&rankby=distance&types=atm&sensor=false&key=AIzaSyA4Dqr-q9w6-_UNfQdtvYOz5ZBEqiRJ61c"
        guard let url = URL(string: urlString) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            DispatchQueue.main.async {
            guard let data = data else { return }
            
            do {
                let decode = JSONDecoder()
                let jsonResponse = try decode.decode(Places.self, from: data)
                self.placesArray = jsonResponse.results
                print(jsonResponse.results)
                print("Count of placesArray :", self.placesArray.count)
                for item in jsonResponse.results {
                    print(item.name)
                    print(item.vicinity)
                }
                self.tableView.reloadData()
            } catch let jsonErr {
                print("Serializing error: ",jsonErr)
            }
          }
        }.resume()
    }
}

extension DataVC:UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = placesArray[indexPath.row].name
        cell.detailTextLabel?.text = placesArray[indexPath.row].vicinity
        return cell
    }
}

