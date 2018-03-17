//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

//Structura con protocolo decodable para poder usar el jsonDecoder (investigar como funciona mas a fondo
struct Restaurante: Decodable {
    var id: Int
    var image: String
    var name: String
    var rating: Int
}

//MealtableViewController, esta es la que se encarga de la contruccion de las tablas
class MealTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //metodo de UITable para seleccionr que tantas secciones se quieren
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //metodo de UITable para seleccionr que tantas filas se quieren
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (loadJson(filename: "rest")?.count)!
    }

    //Este metodo pregunta por los datos de la celda
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        //dequeueReusableCell regresa una celda reusable, y esta la casteamos al tipo de celda que creamos en este caso MealTableViewCell que hereda de UI...cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        //Parseamos el json
        let restaurantes = loadJson(filename: "rest")
        //Populamos la celda con la info del json
        cell.ratingControl.rating = restaurantes![indexPath.row].rating
        cell.nameLabel.text = restaurantes![indexPath.row].name
        cell.photoImageView.image = UIImage(named: restaurantes![indexPath.row].image)
        return cell
    }
    
    //Funcion robada de stack :v
    func loadJson(filename fileName: String) -> [Restaurante]? {
        //Verificamos que exista el archivo con extension json
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                //Not sure what this means: The Data value type allows simple byte buffers to take on the behavior of Foundation objects.
                //Preguntar porque se tiene que castear a Data
                let data = try Data(contentsOf: url)
                
                //usamos el decoder, le asignamos el tipo de estrucutra que va a tomar, que tiene que tener el protocolo decoder o coder, y le decimos de donde tomara los datos
                let jsonData = try JSONDecoder().decode([Restaurante].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
