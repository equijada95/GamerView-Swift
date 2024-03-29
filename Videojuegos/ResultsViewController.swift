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
import CoreData

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YourCellDelegate
{
    
    var videogames : [Videogame] = []
    var image = Image()
    var imageVideogame : UIImageView? = UIImageView()
    var platforms: [Platforms]? = []
    var stores: [Stores]? = []
    var urlVideo : String = ""
    
    var apiRequest = ApiRequests()
    var nameSearch = ""
    var numPage = 0
    var numResults = 0
    
    var videogamesFav : [VideogameFav] = []
    
    
     var coreDataStack: CoreDataStack!
     var managedContext: NSManagedObjectContext!
     {
         get
         {
             return coreDataStack.context
         }
     }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var results: UILabel!
    
    @IBOutlet weak var previousBtn: UIButton!
    

    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNumPage()
        results.text = "Results: \(numResults)"
        
        let favFetchRequest = NSFetchRequest<VideogameFav>(entityName: "VideogameFav")
    
            do
            {
                videogamesFav = try managedContext.fetch(favFetchRequest)
            }
            catch
            {
                print("Error fetching videogames: \(error)")
            }
        

    }
    
    // MARK: Page's Buttons
    
    @IBAction func actionPage(_ sender: UIButton) {
        
        if(sender == nextBtn){
            numPage = numPage + 1
            }
        if(sender == previousBtn){
            
            numPage = numPage - 1
        }
        searchGames(numPage: numPage)
    }
    
    func searchGames(numPage: Int)
    {
        checkNumPage()
        apiRequest.alamoFire(for: nameSearch, for: numPage, completionHandler: {
            search in
            let items = search.results
            self.videogames = items
            self.tableView.reloadData()
        })
    }
    
    func checkNumPage()
    {
        let maxPages : Double = Double(self.numResults)/20
        if(numPage == 1)
        {
            previousBtn.isHidden = true
        }
        if (numPage > 1){
            previousBtn.isHidden = false
        }
        if(numPage > Int(floor(maxPages)))
        {

            self.nextBtn.isHidden = true
        } else{
            
            self.nextBtn.isHidden = false
        }
    }

    // MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCustomCell
            
            cell.nameLabel.text = videogames[indexPath.row].name
        
            let rating = String (videogames[indexPath.row].rating )
            cell.ratingLabel.text = "Rating: \(rating)"
            
            
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
        if let lVC = segue.destination as? ListViewController
        {
            if(platforms!.count > 0){
                lVC.platforms = platforms!
            }
            if(stores!.count > 0){
                lVC.stores = stores!
            }
        }
    }
    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Videogame? {
        return videogames[section]
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertview = UIAlertController(title:"Add Favorites?",message:"Do you want to add this video game to favorites?",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionOk = UIAlertAction(title: "Ok", style: .destructive, handler: {(accion) in
           
        if self.videogamesFav.contains(where: {element in
            if case element.id = Int64(self.videogames[indexPath.row].id){
                return true
            }else{
                return false
            }
        }){
            let alertview = UIAlertController(title:"Repeated Favorite",message:"This video game has been previously added to favorites",preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                                self.present(alertview, animated: true, completion: nil)
        }else{
            self.addFavorite(videogame: self.videogames[indexPath.row])
            }
        })
        
        alertview.addAction(actionOk)
        alertview.addAction(cancelAction)
        self.present(alertview, animated: true, completion: nil)
    }
    
    // MARK: Add Favorite
    
    func addFavorite(videogame: Videogame)
    {
        let videogameEntity = NSEntityDescription.entity(forEntityName: "VideogameFav",
            in: self.managedContext)!
        let videogameFav = VideogameFav(entity: videogameEntity, insertInto:self.managedContext)
        videogameFav.id = Int64(videogame.id)
        videogameFav.name = videogame.name
        videogameFav.image = videogame.image
        videogameFav.rating = videogame.rating
            videogameFav.date = Date()
        if videogame.clip != nil{
            let clipEntity = NSEntityDescription.entity(forEntityName: "ClipFav",
            in: self.managedContext)!
            let clip = ClipFav(entity: clipEntity, insertInto: self.managedContext)
            clip.clip = videogame.clip!.clip
            videogameFav.clip = clip
            }
    
        if videogame.platforms != nil{
            let platformEntity = NSEntityDescription.entity(forEntityName: "PlatformFav",
                                                        in: self.managedContext)!
            let platformsEntity = NSEntityDescription.entity(forEntityName: "PlatformsFav",
                                                        in: self.managedContext)!
            let mutablePlatforms = videogameFav.platforms?.mutableCopy() as! NSMutableSet
            for i in videogame.platforms!
                {
                let platform = PlatformFav(entity: platformEntity, insertInto:self.managedContext)
                    platform.name = i.platform.name
                    platform.id = Int64(i.platform.id)
                let platforms = PlatformsFav(entity: platformsEntity, insertInto:self.managedContext)
                    platforms.platform = platform
                
                mutablePlatforms.add(platforms)
                
                
                }
            videogameFav.platforms = mutablePlatforms as NSSet
            }
        if videogame.stores != nil{
            let storeEntity = NSEntityDescription.entity(forEntityName: "StoreFav",
                                                        in: self.managedContext)!
            let storesEntity = NSEntityDescription.entity(forEntityName: "StoresFav",
                                                        in: self.managedContext)!
            let mutableStores = videogameFav.stores?.mutableCopy() as! NSMutableSet
            for i in videogame.stores!
            {
            let store = StoreFav(entity: storeEntity, insertInto: self.managedContext)
                store.name = i.store.name
                store.id = Int64(i.store.id)
            let stores = StoresFav(entity: storesEntity, insertInto: self.managedContext)
                stores.store = store
            
            mutableStores.add(stores)
            
            }
            videogameFav.stores = mutableStores as NSSet
        }
        self.coreDataStack.saveContext()
        self.videogamesFav.append(videogameFav)
    }
    
    // MARK: Videogame's Buttons
    
    func getPlatforms (cell: MyCustomCell){
        if let indexPath = cell.getIndexPath(){
            if(videogames[indexPath.row].platforms != nil){
                    platforms = videogames[indexPath.row].platforms
            
                    self.performSegue(withIdentifier: "hiddenViewTable", sender: self)
                    platforms = []
                } else{
                    let alertview = UIAlertController(title:"Platforms not found",message:"Sorry but platforms were not found for this videogame",preferredStyle: .alert)
                    alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                    self.present(alertview, animated: true, completion: nil)
                }
        }
    }
    
    func getStores(cell: MyCustomCell)
    {
        if let indexPath = cell.getIndexPath(){
            if(videogames[indexPath.row].stores != nil){
                stores = videogames[indexPath.row].stores
        
                self.performSegue(withIdentifier: "hiddenViewTable", sender: self)
                stores = []
            } else{
                let alertview = UIAlertController(title:"Stores not found",message:"Sorry but stores were not found for this videogame",preferredStyle: .alert)
                alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                self.present(alertview, animated: true, completion: nil)
            }
        }
    }
        
    func playVideo (cell: MyCustomCell)
    {
        if let indexPath = cell.getIndexPath()
        {
            if videogames[indexPath.row].clip?.clip != nil {
                urlVideo = videogames[indexPath.row].clip!.clip
            
                let playerViewController = VideoPlayer.playVideo(urlVideo)!
                
                self.present(playerViewController, animated: true, completion: nil)
            }
            else {
                let alertview = UIAlertController(title:"Clip not found",message:"Sorry but clip was not found for this videogame",preferredStyle: .alert)
                alertview.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
                self.present(alertview, animated: true, completion: nil)
            }
        }
        
    }
}
