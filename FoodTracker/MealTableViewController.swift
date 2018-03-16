//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

struct Restaurante: Decodable {
    var id: Int
    var image: String
    var name: String
    var cal: Int
    var fecha: String
}

class MealTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (loadJson(filename: "rest")?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let restaurantes = loadJson(filename: "rest")
        cell.fecha.text = restaurantes![indexPath.row].fecha
        cell.ratingControl.rating = restaurantes![indexPath.row].cal
        cell.nameLabel.text = restaurantes![indexPath.row].name
        cell.photoImageView.image = UIImage(named: restaurantes![indexPath.row].image)
        return cell
    }
    
    //Funcion robada de stack :v
    func loadJson(filename fileName: String) -> [Restaurante]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([Restaurante].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
