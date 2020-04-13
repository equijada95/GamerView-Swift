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
    
    @IBOutlet weak var dropDownButton: UIButton!
    
    

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        cellDelegate?.didTapButton(cell: self)
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
    
    
    
}

protocol YourCellDelegate : class {
    func didTapButton(cell: MyCustomCell)
}
