//
//  ViewController.swift
//  Videojuegos
//
//  Created by MIMO on 20/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import AVKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YourCellDelegate{
    
    var apiRequest = ApiRequests()
    var items : [Videogame] = []
    var count : Int = 0
    
    var page = 1
    
    var name = ""
    
    var image = Image()
    
    var coreDataStack : CoreDataStack!
    
    var videogames : [VideogameFav] = []
    var urlVideo : String = ""
    var playerViewController = AVPlayerViewController()
    var platforms: NSSet? = []
    var stores: [StoresFav]? = []
 
    var managedContext: NSManagedObjectContext!
    {
        get
        {
            return coreDataStack.context
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        let favFetchRequest = NSFetchRequest<VideogameFav>(entityName: "VideogameFav")
        
                do
                {
                    videogames = try managedContext.fetch(favFetchRequest)
                }
                catch
                {
                    print("Error fetching videogames: \(error)")
                }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    func searchGames(name: String, page: Int)
    {
        apiRequest.alamoFire(for: name, for: page, completionHandler: {
            search in
            self.count = search.count
            let items = search.results
            self.items = items
            self.performSegue(withIdentifier: "push", sender: self)
    }
    )}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tVC = segue.destination as? TableViewController
        {
            tVC.videogames = self.items
            tVC.apiRequest = self.apiRequest
            tVC.nameSearch = self.name
            tVC.numPage = self.page
            tVC.numResults = self.count
            tVC.coreDataStack = self.coreDataStack
            
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! MyCustomCell
            
            cell.nameLabel.text = videogames[indexPath.row].name
            cell.ratingLabel.text = String (videogames[indexPath.row].rating )
            cell.dateLabel.text = dateFormatter.string(from: videogames[indexPath.row].date!)
    
    
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
    
    
    
    
    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> VideogameFav? {
        return videogames[section]
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(videogames[indexPath.section])
    }
    
    func getPlatforms(cell: MyCustomCell) {
        if let indexPath = cell.getIndexPath(){
            if(videogames[indexPath.row].platforms != nil){
                    platforms = videogames[indexPath.row].platforms
                    self.performSegue(withIdentifier: "hiddenViewTable", sender: self)
                    platforms = []
                } else{
                    let alertview = UIAlertController(title:"Platforms not found",message:"Sorry but no platforms found for this videogame",preferredStyle: .alert)
                    alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                    self.present(alertview, animated: true, completion: nil)
                }
        }
    }
    
    func playVideo(cell: MyCustomCell) {
        if let indexPath = cell.getIndexPath()
        {
            if videogames[indexPath.row].clip?.clip != nil {
                urlVideo = videogames[indexPath.row].clip!.clip!
            
                let videoURL = URL(string: urlVideo)
                let player = AVPlayer(url: videoURL!)
                playerViewController.player = player
                
                self.present(playerViewController, animated: true, completion: nil)
            }
            else {
                let alertview = UIAlertController(title:"Trailer not found",message:"Sorry but no trailer found for this videogame",preferredStyle: .alert)
                alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                self.present(alertview, animated: true, completion: nil)
            }
        }
    }
    
    func getStores(cell: MyCustomCell) {
        print("caca")
    }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let name = searchBar.text else { return }
    self.name = name
    searchGames(name: name, page: page)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
  }
}
