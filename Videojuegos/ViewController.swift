//
//  ViewController.swift
//  Videojuegos
//
//  Created by MIMO on 20/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var apiRequest = ApiRequests()
    var items : [Videogame] = []
    var count : Int = 0
    
    var page = 1
    
    var name = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
            
        }

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
