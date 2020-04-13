//
//  TableViewController.swift
//  Videojuegos
//
//  Created by MIMO on 24/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YourCellDelegate
{
    
    
    var videogames : [Videogame] = []
    var image = Image()
    var imageVideogame : UIImageView? = UIImageView()
    var platforms: [Platforms] = []
    
    
    

  //  func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
  //      let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
  //      if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
  //          return indexPath
  //      }
  //      return nil
  //  }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCustomCell
            
            cell.nameLabel.text = videogames[indexPath.row].name
            cell.ratingLabel.text = String (videogames[indexPath.row].rating )
            
            
           let url = videogames[indexPath.row].image
           if(url != nil){
         
            cell.imageVideogame.image = image.getImage(urlString: url!).image
           }
        //    let hCell = tableView.dequeueReusableCell(withIdentifier: "platformViewCell", for: indexPath) as! HiddenCell
        //
        //    hCell.name.text = videogames[indexPath.row].platforms[indexPath.row].platform.name
            
          //  cell.cellDelegate = self
          //  cell.dropDownButton.tag = indexPath.row
            
           // cell.platformTableview.isHidden = true
            
           // var platformTableView : UITableView = UITableView()
            
            cell.cellDelegate = self
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videogames.count
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let hTable = segue.destination as? HiddenTable
    {
        hTable.platforms = platforms
    }
    
    // MARK: UITableViewDataSource methods
    
    
   // func numberOfSections(in tableView: UITableView) -> Int {
   //     return 3
   // }
    
    
   // func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   //  //   if tableView == videogameTable{
   //         return videogames.count
   //  //   }
   //  //   if tableView == platformTable{
   //  //       return videogames[section].platforms.count
   //  //   }else{
   //  //       return 0
   //  //   }
   //
   // }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Videogame? {
        return videogames[section]
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(videogames[indexPath.section])//[indexPath.row])
    }
    
}
    
    func didTapButton (cell: MyCustomCell){//(_ sender: UIButton) {
       // if let indexPath = getCurrentCellIndexPath(sender) {
        if let indexPath = cell.getIndexPath(){//tableView.indexPathForCell(cell) {
            platforms = videogames[indexPath.row].platforms
            
            self.performSegue(withIdentifier: "platforms", sender: self)
        }
        
        
    }
    
}
