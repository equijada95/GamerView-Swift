//
//  MyCustomCell.swift
//  Videojuegos
//
//  Created by MIMO on 24/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit

class MyCustomCell : UITableViewCell
{
    var cellDelegate: YourCellDelegate?
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet weak var imageVideogame: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var btnPlatforms: UIButton!
    
    @IBOutlet weak var btnStores: UIButton!
    
    @IBOutlet weak var btnPlayVideo: UIButton!
    
    
    @IBAction func getPlatforms(_ sender: Any) {
        cellDelegate?.getPlatforms(cell: self)
    }
    
    @IBAction func playVideo(_ sender: Any) {
        cellDelegate?.playVideo(cell: self)
    }
    
    @IBAction func getStores(_ sender: Any) {
        cellDelegate?.getStores(cell: self)
    }
    
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
}

protocol YourCellDelegate : class {
    func getPlatforms(cell: MyCustomCell)
    func playVideo(cell: MyCustomCell)
    func getStores(cell: MyCustomCell)
}

    
