//
//  TableViewController.swift
//  Videojuegos
//
//  Created by MIMO on 24/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import AVKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YourCellDelegate
{
    
    
    var videogames : [Videogame] = []
    var image = Image()
    var imageVideogame : UIImageView? = UIImageView()
    var platforms: [Platforms] = []
    var urlVideo : String = ""
    var playerViewController = AVPlayerViewController()
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCustomCell
            
            cell.nameLabel.text = videogames[indexPath.row].name
            cell.ratingLabel.text = String (videogames[indexPath.row].rating )
            
            
           let url = videogames[indexPath.row].image
           if(url != nil){
         
            cell.imageVideogame.image = image.getImage(urlString: url!).image
           }
            
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
    }
    // MARK: UITableViewDataSource methods
    
    
    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Videogame? {
        return videogames[section]
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(videogames[indexPath.section])//[indexPath.row])
    }
    

    
    func didTapButton (cell: MyCustomCell){
        if let indexPath = cell.getIndexPath(){
            platforms = videogames[indexPath.row].platforms
            
            self.performSegue(withIdentifier: "platforms", sender: self)
        }
    }
        
    func playVideo (cell: MyCustomCell)
    {
        if let indexPath = cell.getIndexPath()
        {
            if videogames[indexPath.row].clip?.clip != nil {
                urlVideo = videogames[indexPath.row].clip!.clip
            
                let videoURL = URL(string: urlVideo)
                let player = AVPlayer(url: videoURL!)
                playerViewController.player = player
                
                self.present(playerViewController, animated: true, completion: nil)
            }
            else {
                let alertview = UIAlertController(title:"Trailer not found",message:"Sorry but no trailer found for this video game",preferredStyle: .alert)
                alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                self.present(alertview, animated:true, completion: nil)
            }
        }
        
    }
}
