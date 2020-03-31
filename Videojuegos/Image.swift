//
//  Image.swift
//  Videojuegos
//
//  Created by MIMO on 31/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import Kingfisher

class Image: UIImageView
{
    let imageView: UIImageView? = UIImageView()
    
    func getImage(urlString: String) -> UIImageView
    {
        
        let url = URL(string: urlString)
        imageView?.kf.setImage(with: url)
        return imageView!
    }
}
