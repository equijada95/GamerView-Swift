//
//  HiddenTable.swift
//  Videojuegos
//
//  Created by MIMO on 03/04/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit


class HiddenTable: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var platforms: [Platforms] = []
    var stores: [Stores] = []
    var platformsFav : [PlatformsFav] = []
    var storesFav : [StoresFav] = []
    
    
    
    // MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hiddenViewCell", for: indexPath) as! MyCustomCell
            if(platforms.count > 0){
                cell.nameLabel.text = platforms[indexPath.row].platform.name
            }
            if(stores.count > 0){
                cell.nameLabel.text = stores[indexPath.row].store.name
            }
            if(platformsFav.count > 0){
                    cell.nameLabel.text = platformsFav[indexPath.row].platform?.name
                }
            if(storesFav.count > 0){
                cell.nameLabel.text = storesFav[indexPath.row].store?.name
            }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(platforms.count > 0){
            return platforms.count
        }
        if(stores.count > 0){
            return stores.count
        }
        if(platformsFav.count > 0){
            return platformsFav.count
        }
        if(storesFav.count > 0){
            return storesFav.count
        }
        return 0
    }
    

    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Codable?
    {
        if(platforms.count > 0){
            return platforms[section].platform
        }
        if(stores.count > 0){
            return stores[section].store
        }
        if(platformsFav.count > 0){
            return platformsFav[section].platform as? Codable
        }
        if(storesFav.count > 0){
            return storesFav[section].store as? Codable
        }
        return nil
    }
    
    
}
