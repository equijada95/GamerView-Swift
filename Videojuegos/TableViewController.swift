//
//  TableViewController.swift
//  Videojuegos
//
//  Created by MIMO on 24/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var videogames : [Videogame] = []
    var image = Image()

    
    // MARK: UITableViewDataSource methods
    
    
   // func numberOfSections(in tableView: UITableView) -> Int {
   //     return 3
   // }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videogames.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCustomCell
        
        cell.nameLabel.text = videogames[indexPath.row].name//[indexPath.row]
        cell.ratingLabel.text = String (videogames[indexPath.row].rating )// as? String
       // let imageVideogame = image.getImage(url: videogames[indexPath.row].image!)
        let url = videogames[indexPath.row].image
        if((url) != nil){
        
            cell.imageVideogame = image.getImage(urlString: url!)
        }
        
        return cell
    }
    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Videogame? {
        return videogames[section]
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(videogames[indexPath.section])//[indexPath.row])
    }
    
}
