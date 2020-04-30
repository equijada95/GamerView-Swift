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
    var platformsFav : [PlatformsFav]? = []
    var storesFav : [StoresFav]? = []
    
    var refresher = UIRefreshControl()
 
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
    
    let favFetchRequest = NSFetchRequest<VideogameFav>(entityName: "VideogameFav")
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        self.retrieveFavorites()
        
        tableView.addSubview(refresher)
        refresher.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Retrieving Favorites
    
    func retrieveFavorites()
    {
        do
        {
            videogames = try managedContext.fetch(favFetchRequest)
        }
        catch
        {
            print("Error fetching videogames: \(error)")
        }
    }
    
    
    @objc func refreshing()
    {
        self.retrieveFavorites()
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
    // MARK: Search Videogames for TableViewController
    
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
        if let hTable = segue.destination as? HiddenTable
        {
            if(platformsFav!.count > 0){
                hTable.platformsFav = platformsFav!
            }
            if(storesFav!.count > 0){
                hTable.storesFav = storesFav!
            }
        }

    }
    
    // MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! MyCustomCell
            cell.nameLabel.text = videogames[indexPath.row].name
            let rating = String (videogames[indexPath.row].rating )
            cell.ratingLabel.text = "Rating: \(rating)"
            let date = dateFormatter.string(from: videogames[indexPath.row].date!)
                
            cell.dateLabel.text = "Added: \(date)"
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
        let alertview = UIAlertController(title:"Delete from Favorites?",message:"Do you want to delete this video game to favorites?",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionOk = UIAlertAction(title: "Ok", style: .destructive, handler: {(accion) in
            self.deleteFav(indexPath: indexPath)
            })
            
        alertview.addAction(actionOk)
        alertview.addAction(cancelAction)
        self.present(alertview, animated: true, completion: nil)
    }
    
    func deleteFav(indexPath: IndexPath)
    {
        let videogame = self.videogames[indexPath.row]
        self.managedContext.delete(videogame)
        self.coreDataStack.saveContext()
        self.videogames.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    // MARK: Videogame's Buttons
    
    func getPlatforms(cell: MyCustomCell) {
        if let indexPath = cell.getIndexPath(){
            if(videogames[indexPath.row].platforms != nil){
                platformsFav = videogames[indexPath.row].platforms?.allObjects as? [PlatformsFav]
                    self.performSegue(withIdentifier: "hiddenViewTable", sender: self)
                    platformsFav = []
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
        if let indexPath = cell.getIndexPath(){
            if(videogames[indexPath.row].stores != nil){
                storesFav = videogames[indexPath.row].stores?.allObjects as? [StoresFav]
                    self.performSegue(withIdentifier: "hiddenViewTable", sender: self)
                    storesFav = []
                } else{
                    let alertview = UIAlertController(title:"Stores not found",message:"Sorry but no stores found for this videogame",preferredStyle: .alert)
                    alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                    self.present(alertview, animated: true, completion: nil)
                }
        }
    }
    
    
}

// MARK: UISearchBarDelegate

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
