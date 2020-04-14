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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "platformViewCell", for: indexPath) as! HiddenCell
        
              cell.nameLabel.text = platforms[indexPath.row].platform.name
        
              return cell
          }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platforms.count
    }
    

    
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Platform?
    {
        return platforms[section].platform
    }
    
    // MARK: UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(platforms[indexPath.section].platform)//[indexPath.row])
    }
    
}
